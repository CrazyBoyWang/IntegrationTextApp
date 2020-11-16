import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:integrationTextApp/configs/network_path_config.dart';
import 'package:integrationTextApp/page/home_page.dart';
import 'package:integrationTextApp/resource/base_resp.dart';

enum LoadingStatus { onLoading, offLoading }

class BaseApiProvider {
  final dio = new Dio();
  static final nonTokenUrls = ['/open-api/', 'https://platform', 'bms/admin-api'];
  static final noAuthUrl = [];

  bool get verify => false;

  BaseApiProvider() {
    dio.options.connectTimeout = TimeConfig.connectTimeout;
    dio.options.receiveTimeout = TimeConfig.receiveTimeout;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      var addToken = true, addAuth = true;

      for (var i = 0; i < nonTokenUrls.length; i++) {
        if (options.uri.toString().contains(nonTokenUrls[i])) {
          addToken = false;
          break;
        }
      }

      for (var i = 0; i < noAuthUrl.length; i++) {
        if (options.uri.toString().contains(noAuthUrl[i])) {
          addAuth = false;
          break;
        }
      }
      options.headers['service-name'] = 'app';
      // if (addAuth) {
      //   options.headers['authorization'] = NetworkConfig.AUTH_KEY;
      //   if (addToken) {
      //     // options.headers['token'] = LocalDataManager.getInstance().getToken();
      //   }
      // }
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) {
      // Do something with response data
      return response; // continue
    }));
  }

  post(url, [var params, var headers]) {
    return _request(Method.post, url, params, headers);
  }

  get(url, [var params, Map<String, dynamic> headers]) {
    return _request(Method.get, url, params, headers);
  }

  put(url, [var params]) {
    return _request(Method.put, url, params);
  }

  _request(method, url, [var params, var headers]) {
    Completer myComplete = Completer();
    Map<String, dynamic> headersMap = headers == null ? new Map() : headers;
    dio.options.headers.addAll(headersMap);

    switch (method) {
      case Method.get:
        dio.get(url, queryParameters: params, options: Options(headers: headers)).then((res) {
          if (verify) {
            myComplete.complete(verifyMiddleWare(res)); // 改动太大了，先不处理
          } else {
            myComplete.complete(res);
          }
        }).catchError((error) {
          myComplete.complete(_handleError(error));
        }).whenComplete(() {});
        break;
      case Method.post:
        dio.post(url, data: params).then((res) {
          if (verify) {
            myComplete.complete(verifyMiddleWare(res)); // 改动太大了，先不处理
          } else {
            myComplete.complete(res);
          }
        }).catchError((error) {
          myComplete.complete(_handleError(error));
        }).whenComplete(() {});
        break;
      case Method.put:
        dio.put(url, queryParameters: params).then((res) {
          if (verify) {
            myComplete.complete(verifyMiddleWare(res)); // 改动太大了，先不处理
          } else {
            myComplete.complete(res);
          }
        }).catchError((error) {
          myComplete.complete(_handleError(error));
        }).whenComplete(() {});
        break;
    }
    return myComplete.future;
  }

  /// 处理自己服务器返回的结果
  BaseResp verifyMiddleWare(dynamic temp) {
    var result;
    if (temp is Response) {
      // 服务器返回正常的情况
      final res = temp.data;
      if (res is DioError) {
        // 有时候会出现这样的情况，忘了什么时候会出现。所以这段代码先不去掉
        if (null != res.response && null != res.response.data && ResponseCode.tokenIllegal.toString() == res.response.data['code']) {
          result = BaseResp(code: ResponseCode.tokenIllegal, result: false, msg: NetworkStatusDes.tokenIllegal, data: null);
        } else {
          result = BaseResp(code: ResponseCode.networkFail, result: false, msg: NetworkStatusDes.defaultStatus, data: null);
        }
      } else {
        if (null != res) {
          int code;
          if (res['code'] is String) {
            code = int.parse(res['code']);
          } else {
            code = res['code'];
          }

          result = BaseResp(code: code, msg: res['msg'], result: ResponseCode.success == code, data: res['data']);
        } else {
          result = BaseResp(code: ResponseCode.networkFail, result: false, msg: '');
        }
      }
    } else {
      // 服务器异常情况
      result = temp;
    }

    if (result is BaseResp && result.code == ResponseCode.tokenIllegal) {
      MyApp.logout();
    }

    return result;
  }

  /// 处理错误
  _handleError(dynamic error) {
    BaseResp resp = new BaseResp(code: ResponseCode.networkFail, result: false, msg: '');

    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          resp.msg = NetworkStatusDes.cancel;
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          resp.msg = NetworkStatusDes.connectTimeout;
          break;
        case DioErrorType.DEFAULT:
          resp.msg = NetworkStatusDes.defaultStatus;
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          resp.msg = NetworkStatusDes.receiveTimeout;
          break;
        case DioErrorType.RESPONSE:
          if (ResponseCode.unauthorized == error.response.statusCode || ResponseCode.forbidden == error.response.statusCode) {
            resp.code = ResponseCode.tokenIllegal;
            resp.msg = NetworkStatusDes.tokenIllegal;
          } else {
            resp.msg = NetworkStatusDes.response;
          }
          break;
        case DioErrorType.SEND_TIMEOUT:
          resp.msg = NetworkStatusDes.sendTimeout;
          break;
      }
    } else {
      resp.msg = NetworkStatusDes.unexpected;
    }
    return resp;
  }
}

/// 网络错误描述
class NetworkStatusDes {
  static final String tokenIllegal = 'token失效~';
  static final String connectTimeout = '网络连接超时';
  static final String sendTimeout = '请求发送超时';
  static final String receiveTimeout = '响应接受超时';
  static final String cancel = '请求取消';
  static final String defaultStatus = '网络错误';
  static final String response = '响应错误';
  static final String unexpected = 'Unexpected error occured';
}

/// 自己服务器和网络请求中的一些响应码
class ResponseCode {
  static final int success = 10000; // 请求成功
  static final int tokenIllegal = 190001; // token失效

  static final int unauthorized = 401; // 未授权
  static final int forbidden = 403; // 被禁止

  static final int networkFail = 4000001;
}

/// 网络时长配置
class TimeConfig {
  static final int connectTimeout = 5000;
  static final int receiveTimeout = 30000;
}

enum Method {
  get,
  post,
  put,
  patch,
  delete,
}

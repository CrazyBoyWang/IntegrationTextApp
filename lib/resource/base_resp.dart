/// <BaseResp<T> 返回 code msg data.
class BaseResp<T> {
  int code;
  String msg;
  bool result;
  T data;


  BaseResp({int code, String msg, bool result, T data, T token}) {
    this.code = code;
    this.msg = msg;
    this.result = result;
    if (null != data) {
      this.data = data;
    }
  }

  factory BaseResp.from(BaseResp origin) =>
      BaseResp(code: origin.code, msg: origin.msg, result: origin.result, data: origin.data);

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write(",\"code\":$code");
    sb.write(",\"msg\":$msg");
    sb.write(",\"result\":$result");
    sb.write(",\"data\":\"$data\"");
    sb.write('}');
    return sb.toString();
  }
}

class CustomRespCode {
  static const networkFail = 4000001;
  static const networkSuccess = 4000002;
}

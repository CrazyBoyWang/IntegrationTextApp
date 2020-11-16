import 'api_config.dart';

class NetworkConfig {
  static String get HOST_URL => ApiConfig.HOST_URL;

  static String get AUTO_URL => ApiConfig.AUTO_URL;


  // static String get ROOMBOX_URL => ApiConfig.ROOMBOX_URL;
  // static String get AUTH_KEY => ApiConfig.AUTH_KEY;
  // static String get UPLOAD_FILE_URL => ApiConfig.UPLOAD_FILE_URL;

  // 新首页增加的接口
  // ignore: non_constant_identifier_names
  static final Map<String, String> Login = {
    'Login': HOST_URL + '/auth/open-api/app-user/v1/gt-login',
    // final movieURL = "http://oapi.t.blingabc.com";
  };

  //调用自动化测试接口
  static final Map<String, String> SetClass = {
    //AR登录
    'ARLogin': HOST_URL + "/auth/open-api/login/v1/get-login-info",

    //添加课时
    'AddLesson': HOST_URL + "/bms/admin-api/lesson/v1/insert",

    'IssureLesson': HOST_URL + "/bms/admin-api/lesson/v1/update/state",

    'GetLessonId': AUTO_URL + "/api/integration/queryid",
  };
}

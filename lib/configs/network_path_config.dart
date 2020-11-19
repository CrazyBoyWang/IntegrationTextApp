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

  //  发布课时
    'IssueLesson': HOST_URL + "/bms/admin-api/lesson/v1/update/state",
//组建课程
    'SetUpCourses': HOST_URL + "/bms/admin-api/course/v1/insert",

  //发布课程
    'IssueCourses': HOST_URL + "/bms/admin-api/course/v1/update",

    //新增模板
    'NewMould': HOST_URL + "/bms/admin-api/template/v1/insert",

    //发布模板
    'issueMould': HOST_URL + "/bms/admin-api/classinfo/v1/batch/release",

    //上架班级
    'GroundClass': HOST_URL + "/bms/admin-api/classinfo/v1/batch/release?ids=115912",








    //数据库请求部分
    'GetLessonId': AUTO_URL + "/api/integration/queryid",
    'GetCourseNameType': AUTO_URL + "/api/integration/courseNameType",
   // 'GetCourseNameType': HOST_URL + "/bms/admin-api/general/course/v1/list",


    'GetCourseIds': AUTO_URL + "/api/integration/classId"



  };
}

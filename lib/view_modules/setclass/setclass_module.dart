import 'package:dio/dio.dart';
import 'package:integrationTextApp/services/setclass/setclass_service.dart';

class SetClass {
  CreateClass _createClassRequest = CreateClass();

  requestARLogin(String userName, String passWord) {
    Map<String, dynamic> data = {"username": userName, "password": passWord, "platformCode": "0007"};
    return _createClassRequest.ARLogin(data);
  }

//添加课时
  requestAddLesson(String className) {
    Map<String, dynamic> data = {"name": className, "lessonNum": "null", "isTestCourse": "0", "whenLong": "40", "vocabulary": "", "term": "20", "level": "20", "courseType": "", "remark": "测试跑接口 ", "lessonWay": "1", "materialType": "10", "subjectName": "英语", "subjectCode": "10", "coveUrl": "", "lessonType": "2", "resources": []};
    return _createClassRequest.AddLesson(data);
  }

//发布课时
  requestIssueLesson(int lessonId) {
    Map<String, dynamic> data = {"id": lessonId, "state": "20"};
    return _createClassRequest.IssueLesson(data);
  }

//组建课程
  requestSetUpCourses(String classCourseName, String className, int lessonId, int resCode) {
    Map<String, dynamic> data = {
      "term": 10,
      "level": 20,
      "courseType": resCode,
      "year": 2020,
      "courseChannel": 22,
      "classStyle": 4,
      "remark": "api测试课程 ",
      "classWay": 1,
      "courseName": classCourseName,
      "courseDescribe": "可以",
      "subjectCode": 10,
      "teachingContent": "201",
      "experienceType": "36",
      "coveUrl": "null",
      "courseLessonList": [
        {"lessonName": className, "lessonId": lessonId, "lessonWay": 1, "teacherRole": 1}
      ],
      "subjectName": "英语"
    };
    return _createClassRequest.SetUpCourses(data);
  }

  //发布课程
  requestIssueCourses(int addCoursesId, String classCourseName) {
    Map<String, dynamic> data = {
      "id": addCoursesId,
      "courseName": classCourseName, //courseName
      "year": DateTime.now().year,
      "state": 20,
    };
    return _createClassRequest.IssueCourses(data);
  }

//新增模板
  requestNewMould(int lessonId, int addCoursesId, String className) {
    Map<String, dynamic> data = {
      "channelGrade": 3,
      "courseChannelCode": 60,
      "syncStatus": 0,
      "sendMaterial": "0",
      "courseId": addCoursesId, //lessonid
      "templateTimes": [
        {"openClassNum": 1}
      ],
      "schoolTimeStatus": 0,
      "templateLessonList": [
        {
          "lessonId": lessonId, //course_id
          "name": className, //课时名称
          "price": "0",
          "showPrice": "0",
          "contractPrice": "0",
          "teacherRole": "1"
        }
      ],
      "liveContain": "10",
      "commentStatus": "0",
      "freeLesson": "1",
      "entryClassTimeList": {"entryDate": "", "entryHour": "", "entryMinute": ""}
    };
    return _createClassRequest.NewMould(data);
  }

  requestGroundClass(int classId) {
    FormData formData = FormData.fromMap({"ids": classId});

    return _createClassRequest.GroundClass(formData);
  }

  //创建订单
  requestCreateOrder(int classId, String classCode) {
    Map<String, dynamic> data = {
      "orderChannel": "11",
      "classList": [
        {
          "id": classId, // queryClassIdService--id
          "classCode": classCode //queryClassIdService--classcode
        }
      ],
      "createId": "20",
      "stuNum": "602089071",
      "userCode": "crmadmin",
      "discountId": "",
      "useCouponCode": [],
      "sendCouponCodes": [],
      "courseFavorableState": "1",
      "remark": "",
      "isFreePayment": "0",
      "orderTotalPrice": "0",
      "orderMaterialsPrice": "0",
      "checkFlage": "1",
      "couponList": []
    };
    return _createClassRequest.CreateOrder(data);
  }

//   requestGroundClass(int classId) async {
//    ///创建Dio
//    Dio dio = new Dio();
//    ///发送 FormData:
//    FormData formData = FormData.fromMap({"ids":classId});
//    String url ="https://oapi.t.blingabc.com/bms/admin-api/classinfo/v1/batch/release";
// //   HttpHeaders.requestHeaders.add("token:eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJjb20ueGRmLmJsaW5nIiwiYXVkIjoiY2xpZW50IiwidXNlcmNvZGUiOiJjcm1hZG1pbiIsImV4cCI6MTYwNzA0OTUwOCwiaWF0IjoxNjA2NDQ0NzA4fQ.go4-Uv2QJZyQkVLrwKiFKnDqOFT8n70ejCr7biUZEZITTPZg6GCgT8kAHuo-i8mgSWxl7ETbj2TQmsQ7u9cTSQ");
//
//    ///发起 post 请求 如这里的注册用户信息
//    Response response = await dio.post(url, data: formData);
//    print(response.data);
//
//  }

// //发布模板
// requestIssueMould(int issueMould){
//   Map<String,dynamic> data={
//     "ids": issueMould
//   };
//   return _createClassRequest.issueMould(data);
// }

}

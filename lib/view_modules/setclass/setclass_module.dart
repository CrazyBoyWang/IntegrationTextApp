import 'package:integrationTextApp/services/setclass/setclass_service.dart';

class SetClass {
  CreateClass _createClassRequest = CreateClass();

  requestARLogin(String userName, String passWord) {
    Map<String, dynamic> data = {"username": userName, "password": passWord, "platformCode": "0007"};
    return _createClassRequest.ARLogin(data);
  }

//添加课时
  requestAddLesson(String className) {
    Map<String, dynamic> data = {"name": className, "lessonNum": "null", "isTestCourse": "0", "whenLong": "40", "vocabulary": "", "term": "20", "level": "96", "courseType": "", "remark": "测试跑接口 ", "lessonWay": "1", "materialType": "10", "subjectName": "英语", "subjectCode": "10", "coveUrl": "", "lessonType": "2", "resources": []};
    return _createClassRequest.AddLesson(data);
  }

//发布课时
  requestIssureLesson(int lessonId) {
    Map<String, dynamic> data = {"id": lessonId, "state": "20"};
    return _createClassRequest.IssureLesson(data);
  }

//组建课程
  requestSetUpCourses(String classCourseName, String className, int lessonId, int resCode) {
    Map<String, dynamic> data = {
      "term": 10,
      "level": 95,
      "courseType": resCode,
      "year": 2020,
      "courseChannel": 89,
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
}

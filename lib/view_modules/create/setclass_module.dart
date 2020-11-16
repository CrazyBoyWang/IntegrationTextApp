import 'package:integrationTextApp/services/create/setclass_service.dart';

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
}

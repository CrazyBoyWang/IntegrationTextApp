import 'package:integrationTextApp/services/datasource/setclass_db_service.dart';

class DataSourceRequest {
  CreateClassDB _createClassDB = CreateClassDB();

  requestGetLessonId(String classLessonName) {
    Map<String, dynamic> data = {"lessonName": classLessonName};
    return _createClassDB.GetLessonId(data);
  }

  requestGetCourseNameType() {
    Map<String, dynamic> data = {};
    return _createClassDB.GetCourseNameType(data);
  }


  requestGetCourseIds(String classCourseName) {
    Map<String, dynamic> data = {"courseName":classCourseName};

    return _createClassDB.GetCourseIds(data);
  }





}

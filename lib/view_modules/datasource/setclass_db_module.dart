import 'package:integrationTextApp/services/datasource/setclass_db_service.dart';


class DataSourceRequest {
  CreateClassDB _createClassDB = CreateClassDB();

  requestGetLessonId(String classLessonName) {
    Map<String, dynamic> data = {"lessonName": classLessonName};
    return _createClassDB.getLessonId(data);
  }
}

import 'dart:math';

import 'package:integrationTextApp/common/base-api-provider.dart';
import 'package:integrationTextApp/configs/network_path_config.dart';
import 'package:integrationTextApp/resource/base_resp.dart';

class CreateClassDB extends BaseApiProvider {
  Future<BaseResp> GetLessonId(Map<String, dynamic> params) async {
    print(params);
    final response = await get(NetworkConfig.SetClass['GetLessonId'], params, {"requestId": 1});

    return super.verifyMiddleWare(response);
  }

  Future<BaseResp> GetCourseNameType(Map<String, dynamic> params) async {
    //   print(params);
    final response = await get(NetworkConfig.SetClass['GetCourseNameType'],params, {"requestId": 2});

    return super.verifyMiddleWare(response);
  }




  Future<BaseResp> GetCourseIds(Map<String, dynamic> params) async {
    //   print(params);
    final response = await get(NetworkConfig.SetClass['GetCourseIds'],params, {"requestId": 2});

    return super.verifyMiddleWare(response);
  }

}

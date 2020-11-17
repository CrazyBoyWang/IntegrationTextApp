import 'package:integrationTextApp/common/base-api-provider.dart';
import 'package:integrationTextApp/configs/network_path_config.dart';
import 'package:integrationTextApp/resource/base_resp.dart';

class CreateClassDB extends BaseApiProvider {
  Future<BaseResp> getLessonId(Map<String, dynamic> params) async {
    print(params);

    final response = await get(NetworkConfig.SetClass['GetLessonId'], params, {"requestId": 1});

    return super.verifyMiddleWare(response);
  }
}

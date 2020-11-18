
import 'package:integrationTextApp/common/base-api-provider.dart';
import 'package:integrationTextApp/common/setclass/proptities.dart';
import 'package:integrationTextApp/common/setclass/proptities.dart';
import 'package:integrationTextApp/configs/network_path_config.dart';
import 'package:integrationTextApp/resource/base_resp.dart';

class CreateClass extends BaseApiProvider {
  Future<BaseResp> ARLogin(Map<String, dynamic> params) async {
    print(params);
    final response = await post(NetworkConfig.SetClass['ARLogin'], params);
    return super.verifyMiddleWare(response);
  }



  Future<BaseResp> AddLesson(Map<String, dynamic> params) async {
    print(params);
    //带token传参
    final response = await post(NetworkConfig.SetClass['AddLesson'],params,{"token":SetClassParameter.token});

    return super.verifyMiddleWare(response);
  }



  Future<BaseResp> IssureLesson(Map<String, dynamic> params) async {
    print(params);
    //带token传参
    final response = await post(NetworkConfig.SetClass['IssureLesson'], params, {"token": SetClassParameter.token});

    return super.verifyMiddleWare(response);
  }



  Future<BaseResp> SetUpCourses(Map<String, dynamic> params) async {
    print(params);
    //带token传参
    final response = await post(NetworkConfig.SetClass['IssureLesson'], params);

    return super.verifyMiddleWare(response);
  }


}

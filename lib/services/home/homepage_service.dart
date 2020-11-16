import 'dart:io';

import 'package:flutter/material.dart';
import 'package:integrationTextApp/common/base-api-provider.dart';
import 'package:integrationTextApp/configs/network_path_config.dart';
import 'package:integrationTextApp/resource/base_resp.dart';

class HomeRequest extends BaseApiProvider {
  Future<BaseResp> requestMovieList(Map<String, dynamic> params) async {
    print(params);

    final response = await post(NetworkConfig.Login['Login'], params);
    return super.verifyMiddleWare(response);
  }
}

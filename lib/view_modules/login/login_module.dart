import 'package:flutter/material.dart';
import 'package:integrationTextApp/common/base-api-provider.dart';
import 'package:integrationTextApp/services/create/setclass_service.dart';
import 'package:integrationTextApp/services/home/homepage_service.dart';

class LoginVM {
  HomeRequest _homeRequest = HomeRequest();
  requestLogin(String mobile, String pwd, BuildContext context) {
    Map<String, dynamic> a = {"mobile": mobile, "password": pwd};
    return _homeRequest.requestMovieList(a);
  }
}

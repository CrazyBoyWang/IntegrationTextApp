import 'dart:io';

import 'package:flutter/services.dart';
import 'package:integrationTextApp/datas/local_data.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';

/// 获取系统信息
Future<void> initSystemInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  LocalData.ins.setAppVersion(packageInfo.version);

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Map<String, dynamic> bugExtra;
  String model;
  String osVersion;

  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      LocalData.ins.setAndroidDeviceInfo(androidInfo);
      bugExtra = _readAndroidBuildData(androidInfo);
      model = androidInfo.model;
      osVersion = androidInfo.version.release;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      LocalData.ins.setIosDeviceInfo(iosInfo);
      bugExtra = _readIosDeviceInfo(iosInfo);
      model = iosInfo.utsname.machine;
      osVersion = iosInfo.systemVersion;
    }
  } on PlatformException {
    bugExtra = <String, dynamic>{'Error:': 'Failed to get platform version.'};
  }
  LocalData.ins.setModel(model);
  LocalData.ins.setOsVersion(osVersion);
  LocalData.ins.setBugExtra(bugExtra);
}

/// 获取android设备信息
Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'board': build.board,
    'bootloader': build.bootloader,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'manufacturer': build.manufacturer,
    'product': build.product,
  };
}

/// 获取ios设备信息
Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  return <String, dynamic>{
    'name': data.name,
    'systemName': data.systemName,
    'systemVersion': data.systemVersion,
    'model': data.model,
    'identifierForVendor': data.identifierForVendor,
  };
}

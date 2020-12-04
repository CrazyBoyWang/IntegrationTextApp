import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';

class LocalData {
  LocalData._();

  static final LocalData ins = LocalData._(); // 实例

  int timeDiffer = 0; //接口与本地时间的时间差
  static String _appVersion; // app版本
  static String _model; // 手机型号
  static String _osVersion; // 手机型号
  static Map<String, dynamic> _bugExtra; // 错误信息的额外参数
  static AndroidDeviceInfo _androidDeviceInfo;
  static IosDeviceInfo _iosDeviceInfo;
  static final bool _isAndroid = !Platform.isIOS;
  static int _loginTime = 0;
  static bool _isWxInstall;
  static int timeDelay = 0; // 进入课前课后时的本地时间与服务器时间的误差对比

  void setAppVersion(String version) {
    _appVersion = version;
  }

  String getAppVersion() {
    return _appVersion;
  }

  void setModel(String model) {
    _model = model;
  }

  String getModel() {
    return _model;
  }

  void setOsVersion(String osVersion) {
    _osVersion = osVersion;
  }

  String getOsVersion() {
    return _osVersion;
  }

  void setBugExtra(Map<String, dynamic> bugExtra) {
    _bugExtra = bugExtra;
  }

  Map<String, dynamic> getBugExtra() {
    return _bugExtra;
  }

  bool isAndroid() {
    return _isAndroid;
  }

  int getLoginTime() {
    return _loginTime;
  }

  bool isWxInstall() {
    return _isWxInstall;
  }

  void setWxInstall(bool install) {
    _isWxInstall = install;
  }

  void setAndroidDeviceInfo(AndroidDeviceInfo androidDeviceInfo) {
    _androidDeviceInfo = androidDeviceInfo;
  }

  void setIosDeviceInfo(IosDeviceInfo iosDeviceInfo) {
    _iosDeviceInfo = iosDeviceInfo;
  }

  Map<String, dynamic> getAndroidDeviceInfo() {
    if (null != _androidDeviceInfo) {
      return <String, dynamic>{
        'androidVersionSecurityPatch': _androidDeviceInfo.version.securityPatch,
        'androidVersionSdkInt': _androidDeviceInfo.version.sdkInt,
        'androidVersionRelease': _androidDeviceInfo.version.release,
        'androidVersionPreviewSdkInt': _androidDeviceInfo.version.previewSdkInt,
        'androidVersionIncremental': _androidDeviceInfo.version.incremental,
        'androidVersionCodename': _androidDeviceInfo.version.codename,
        'androidVersionBaseOS': _androidDeviceInfo.version.baseOS,
        'androidBoard': _androidDeviceInfo.board,
        'androidBootloader': _androidDeviceInfo.bootloader,
        'androidBrand': _androidDeviceInfo.brand,
        'androidDevice': _androidDeviceInfo.device,
        'androidDisplay': _androidDeviceInfo.display,
        'androidFingerprint': _androidDeviceInfo.fingerprint,
        'androidHardware': _androidDeviceInfo.hardware,
        'androidHost': _androidDeviceInfo.host,
        'androidManufacturer': _androidDeviceInfo.manufacturer,
        'androidModel': _androidDeviceInfo.model,
        'androidProduct': _androidDeviceInfo.product,
        'androidSupported32BitAbis': _androidDeviceInfo.supported32BitAbis,
        'androidSupported64BitAbis': _androidDeviceInfo.supported64BitAbis,
        'androidSupportedAbis': _androidDeviceInfo.supportedAbis,
        'androidTags': _androidDeviceInfo.tags,
        'androidType': _androidDeviceInfo.type,
        'androidId': _androidDeviceInfo.androidId
      };
    } else {
      return <String, dynamic>{
        'androidVersionSecurityPatch': null,
        'androidVersionSdkInt': null,
        'androidVersionRelease': null,
        'androidVersionPreviewSdkInt': null,
        'androidVersionIncremental': null,
        'androidVersionCodename': null,
        'androidVersionBaseOS': null,
        'androidBoard': null,
        'androidBootloader': null,
        'androidBrand': null,
        'androidDevice': null,
        'androidDisplay': null,
        'androidFingerprint': null,
        'androidHardware': null,
        'androidHost': null,
        'androidId': null,
        'androidManufacturer': null,
        'androidModel': null,
        'androidProduct': null,
        'androidSupported32BitAbis': null,
        'androidSupported64BitAbis': null,
        'androidSupportedAbis': null,
        'androidTags': null,
        'androidType': null,
      };
    }
  }

  Map<String, dynamic> getIosDeviceInfo() {
    if (null != _iosDeviceInfo) {
      return <String, dynamic>{
        'iosName': _iosDeviceInfo.name,
        'iosSystemName': _iosDeviceInfo.systemName,
        'iosSystemVersion': _iosDeviceInfo.systemVersion,
        'iosModel': _iosDeviceInfo.model,
        'iosLocalizedModel': _iosDeviceInfo.localizedModel,
        'iosIdentifierForVendor': _iosDeviceInfo.identifierForVendor,
        'iosUtsnameSysname:': _iosDeviceInfo.utsname.sysname,
        'iosUtsnameNodename:': _iosDeviceInfo.utsname.nodename,
        'iosUtsnameRelease:': _iosDeviceInfo.utsname.release,
        'iosUtsnameVersion:': _iosDeviceInfo.utsname.version,
        'iosUtsnameMachine:': _iosDeviceInfo.utsname.machine,
      };
    } else {
      return <String, dynamic>{
        'iosName': null,
        'iosSystemName': null,
        'iosSystemVersion': null,
        'iosModel': null,
        'iosLocalizedModel': null,
        'iosIdentifierForVendor': null,
        'iosUtsnameSysname:': null,
        'iosUtsnameNodename:': null,
        'iosUtsnameRelease:': null,
        'iosUtsnameVersion:': null,
        'iosUtsnameMachine:': null,
      };
    }
  }
}

import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_lock_flutter/executables/controllers/apps_controller.dart';
import 'package:app_lock_flutter/services/constant.dart';
import 'package:usage_stats/usage_stats.dart';

import 'permission_controller.dart';

class MethodChannelController extends GetxController implements GetxService {
  static const platform = MethodChannel('flutter.native/helper');

  bool isOverlayPermissionGiven = false;
  bool isUsageStatPermissionGiven = false;
  bool isNotificationPermissionGiven = false;

  Future<bool> checkOverlayPermission() async {
    try {
      return await platform
          .invokeMethod('checkOverlayPermission')
          .then((value) {
        log("$value", name: "checkOverlayPermission");
        isOverlayPermissionGiven = value as bool;
        update();
        return isOverlayPermissionGiven;
      });
    } on PlatformException catch (e) {
      log("Failed to Invoke: '${e.message}'.");
      isOverlayPermissionGiven = false;
      update();
      return isOverlayPermissionGiven;
    }
  }

  Future<bool> checkNotificationPermission() async {
    return isNotificationPermissionGiven =
        await Permission.notification.isGranted;
  }

  Future<bool> checkUsageStatePermission() async {
    isUsageStatPermissionGiven =
        (await UsageStats.checkUsagePermission() ?? false);
    update();
    return isUsageStatPermissionGiven;
  }

  addToLockedAppsMethod() async {
    try {
      Map<String, dynamic> data = {
        "app_list": Get.find<AppsController>().lockList.map((e) {
          return {
            "app_name": e.application!.appName,
            "package_name": e.application!.packageName,
            "file_path": e.application!.apkFilePath,
          };
        }).toList()
      };
      await setPassword();
      await platform.invokeMethod('addToLockedApps', data).then((value) {
        log("$value", name: "addToLockedApps CALLED");
      });
    } on PlatformException catch (e) {
      log("Failed to Invoke: '${e.message}'.");
    }
  }

  Future setPassword() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      String data = prefs.getString(AppConstants.setPassCode) ?? "";
      log(data, name: "PASSWORD--");
      if (data != "") {
        await platform.invokeMethod('setPasswordInNative', data).then((value) {
          log("$value", name: "setPasswordInNative CALLED");
        });
      }
    } on PlatformException catch (e) {
      log("Failed to Invoke: '${e.message}'.");
    }
  }

  Future stopForeground() async {
    try {
      await platform.invokeMethod('stopForeground', "").then((value) {
        log("$value", name: "stopForeground CALLED");
      });
    } on PlatformException catch (e) {
      log("Failed to Invoke: '${e.message}'.");
    }
  }

  Future<bool> askNotificationPermission() async {
    // await AppSettings.openAppSettings();
    await Get.find<PermissionController>()
        .getPermission(Permission.notification);
    isNotificationPermissionGiven = await Permission.notification.isGranted;
    update();
    return isNotificationPermissionGiven;
  }

  Future<bool> askOverlayPermission() async {
    try {
      return await platform.invokeMethod('askOverlayPermission').then((value) {
        log("$value", name: "askOverlayPermission");
        isOverlayPermissionGiven = (value as bool);
        update();
        return isOverlayPermissionGiven;
      });
    } on PlatformException catch (e) {
      log("Failed to Invoke: '${e.message}'.");
      return false;
    }
  }

  Future<bool> askUsageStatsPermission() async {
    try {
      return await platform
          .invokeMethod('askUsageStatsPermission')
          .then((value) {
        log("$value", name: "askUsageStatsPermission");
        return (value as bool);
      });
    } on PlatformException catch (e) {
      log("Failed to Invoke: '${e.message}'.");
      return false;
    }
  }
}

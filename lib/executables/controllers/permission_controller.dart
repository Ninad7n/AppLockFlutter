import 'dart:developer';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController implements GetxService {
  Future<void> getPermission(Permission permsn) async {
    var status;
    if (!(await permsn.isGranted)) {
      status = await permsn.request();
      log("___________________-----$status-----___________________1",
          name: permsn.toString());
    } else {
      log("___________________-----Granted-----___________________2",
          name: permsn.toString());
    }
    log("$status", name: "Permission Status");
  }
}

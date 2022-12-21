import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/constant.dart';

class AuthRepo {
  SharedPreferences prefs;
  AuthRepo({required this.prefs});

  Future setUserId(String userId) async {
    prefs.setString(AppConstants.userId, userId);
    log("USERID $userId");
  }

  String getUserToken() {
    return prefs.getString(AppConstants.token) ?? "";
  }

  setUserToken(token) {
    prefs.setString(AppConstants.token, token);
  }

  String getUserId() {
    return prefs.getString(AppConstants.userId) ?? "";
  }

  bool isLoggedIn() {
    return prefs.containsKey(AppConstants.token);
  }

  bool clearSharedData() {
    prefs.remove(AppConstants.token);
    prefs.remove(AppConstants.userId);
    return true;
  }
}

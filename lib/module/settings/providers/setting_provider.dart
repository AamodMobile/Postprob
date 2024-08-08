import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as firebase_user;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/login/view/login_view.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassWord = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  int isNotification = 0;
  bool isHide = true;
  firebase_user.User? user;

  void isShow(bool show) {
    isHide = show;
    notifyListeners();
  }

  void updateNotification(int value, BuildContext context, bool isFast) {
    isNotification = value;
    manageNotification(context, isNotification.toString(), isFast);
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    try {
      showProgress(context);
      var result = await ApiService.logout();
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          signOutGoogle();
          closeProgress(context);
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.clear();
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginView()), (route) => false);
            successToast(context, json["message"].toString());
          }
        } else {
          closeProgress(context);
          errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      if (context.mounted) {
        closeProgress(context);
        Log.console(e.toString());
      }
    }
    notifyListeners();
  }

  Future<void> signOutGoogle() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await auth.signOut();
    user = null;
    notifyListeners();
    Log.console("User Signed Out");
  }

  Future<void> changePassword(BuildContext context, String password, String newPassword, String confirmPassword) async {
    try {
      showProgress(context);
      var result = await ApiService.changePassword(password, newPassword, confirmPassword);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          Navigator.pop(context);
          successToast(context, json["message"].toString());
        } else {
          closeProgress(context);
          errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      if (context.mounted) {
        closeProgress(context);
        Log.console(e.toString());
      }
    }
    notifyListeners();
  }

  Future<void> manageNotification(BuildContext context, String isOn, bool isFast) async {
    try {
      if (isFast == false) {
        showProgress(context);
      }
      var result = await ApiService.manageNotification(isOn);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          if (isFast == false) {
            closeProgress(context);
            successToast(context, json["message"].toString());
          }
        } else {
          if (isFast == false) {
            closeProgress(context);
            errorToast(context, json["message"].toString());
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        if (isFast == false) {
          closeProgress(context);
        }
        Log.console(e.toString());
      }
    }
    notifyListeners();
  }
}

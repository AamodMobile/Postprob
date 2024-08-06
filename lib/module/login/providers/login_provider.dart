import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/dashboard/view/dashboard_view.dart';
import 'package:postprob/module/login/model/user_model.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  String mobileNo = "";
  String passwordV = "";
  TextEditingController password = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isHide = true;

  void reset() {
    password.clear();
    emailController.clear();
    passwordV = "";
    mobileNo = "";
  }

  void emailUpdate(String email) {
    emailController.text = email;
    notifyListeners();
  }

  void passwordUpdate(String passwordT) {
    password.text = passwordT;
    notifyListeners();
  }

  void isShow(bool show) {
    isHide = show;
    notifyListeners();
  }

  String? emailValidator(value) {
    const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    final regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Enter an email';
    } else if (!regExp.hasMatch(
      value.toString().trim(),
    )) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  Future<void> loginApiCall(BuildContext context) async {
    try {
      showProgress(context);
      var result = await ApiService.loginApi(emailController.text, password.text);
      var json = jsonDecode(result.body);
      final apiResponse = UserModel.fromJson(json);
      if (context.mounted) {
        if (json["status"] == true) {
          password.text = "";
          emailController.text = "";
          closeProgress(context);
          var pref = await SharedPreferences.getInstance();
          await pref.setString('currentUser', jsonEncode(apiResponse.toJson()));
          await pref.setString('currentToken', apiResponse.accessToken.toString());
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashboardView(index: 0)), (route) => false);
            successToast(context, json["message"]);
          }
        } else {
          closeProgress(context);
          errorToast(context, json["message"]);
        }
      }
    } catch (e) {
      if (context.mounted) {
        closeProgress(context);
        Log.console(e.toString());
      }
    }
  }
  Future<void> googleLoginApiCall(BuildContext context,String email,String googleId) async {
    try {
      showProgress(context);
      var result = await ApiService.googleLogin(email, googleId);
      var json = jsonDecode(result.body);
      final apiResponse = UserModel.fromJson(json);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          var pref = await SharedPreferences.getInstance();
          await pref.setString('currentUser', jsonEncode(apiResponse.toJson()));
          await pref.setString('currentToken', apiResponse.accessToken.toString());
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashboardView(index: 0)), (route) => false);
            successToast(context, json["message"]);
          }
        } else {
          closeProgress(context);
          errorToast(context, json["message"]);
        }
      }
    } catch (e) {
      if (context.mounted) {
        closeProgress(context);
        Log.console(e.toString());
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    Log.console(credential.idToken.toString());
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  Future<void> signOutGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    Log.console("User Signed Out");
  }
}

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as firebase_user;
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
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

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
    } else if (!regExp.hasMatch(value.toString().trim())) {
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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardView(index: 0)),
              (route) => false,
            );
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

  Future<void> googleLoginApiCall(BuildContext context, String email, String googleId, String image) async {
    try {
      showProgress(context);
      var result = await ApiService.googleLogin(email, googleId, image);
      var json = jsonDecode(result.body);
      final apiResponse = UserModel.fromJson(json);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          var pref = await SharedPreferences.getInstance();
          await pref.setString('currentUser', jsonEncode(apiResponse.toJson()));
          await pref.setString('currentToken', apiResponse.accessToken.toString());
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardView(index: 0)),
              (route) => false,
            );
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

  Future<firebase_user.User?> signInWithGoogle(BuildContext context) async {
    try {
      await auth.signOut();
      await googleSignIn.signOut();
      var pref = await SharedPreferences.getInstance();
      await pref.clear();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        if (context.mounted) {
          errorToast(context, "Not Found data");
        }
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await auth.signInWithCredential(credential);
      final firebase_user.User? user = userCredential.user;
      if (user != null) {
        if (context.mounted) {
          await googleLoginApiCall(context, user.email.toString(), user.uid.toString(), user.photoURL.toString());
        }
      }
      return user;
    } catch (e) {
      Log.console(e.toString());
      return null;
    }
  }
}

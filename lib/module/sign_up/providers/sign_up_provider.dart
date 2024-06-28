import 'dart:convert';

import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/route_animation.dart';
import 'package:postprob/module/dashboard/view/dashboard_view.dart';
import 'package:postprob/module/login/model/user_model.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpProvider extends ChangeNotifier {
  String mobileNo = "";
  String passwordV = "";
  String nameV = "";
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void reset() {
    password.clear();
    emailController.clear();
    name.clear();
    passwordV = "";
    mobileNo = "";
    nameV = "";
  }

  void emailUpdate(String email) {
    emailController.text = email;
    notifyListeners();
  }

  void passwordUpdate(String passwordT) {
    password.text = passwordT;
    notifyListeners();
  }

  void nameUpdate(String nameT) {
    name.text = nameT;
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

  Future<void> registerApiCall(BuildContext context) async {
    try {
      showProgress(context);
      var result = await ApiService.register(name.text, emailController.text, password.text);
      var json = jsonDecode(result.body);
      final apiResponse = UserModel.fromJson(json);
      if (json["status"] == true) {
        closeProgress(context);
        var pref = await SharedPreferences.getInstance();
        await pref.setString(
          'currentUser',
          jsonEncode(apiResponse.toJson()),
        );
        await pref.setString('currentToken', apiResponse.accessToken.toString());
        Navigator.pushAndRemoveUntil(context, createRightToLeftRoute(const DashboardView()), (route) => false);
        successToast(context, json["message"]);
      } else {
        closeProgress(context);
        errorToast(context, json["message"]);
      }
    } catch (e) {
      closeProgress(context);
      Log.console(e.toString());
    }
  }
}

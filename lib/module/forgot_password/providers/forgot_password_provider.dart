import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/constants/util.dart';
import 'package:postprob/module/forgot_password/view/check_mail_view.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';

class ForgotPasswordProvider extends ChangeNotifier{
  TextEditingController emailController = TextEditingController();
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
  void emailUpdate(String email) {
    emailController.text = email;
    notifyListeners();
  }
  Future<void> forgetPasswordApiCall(BuildContext context) async {
    try {
      showProgress(context);
      var result = await ApiService.forgetPassword(emailController.text);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckMailView()));
          successToast(context, json["message"]);
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
}
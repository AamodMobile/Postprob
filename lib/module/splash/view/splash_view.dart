import 'dart:convert';

import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/dashboard/view/dashboard_view.dart';
import 'package:postprob/module/intro/view/intro_view.dart';
import 'package:postprob/module/login/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigator();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF130160),
        body: Center(
          child: Image.asset(
            splash,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  _navigator() async {
    var instance = await SharedPreferences.getInstance();
    var crtData = instance.getString('currentUser');
    await Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        if (crtData != null) {
          UserModel crtUser = UserModel.fromJson(jsonDecode(crtData));
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashboardView(index: 0)), (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(context, createRightToLeftRoute(const IntroView()), (route) => false);
        }
      },
    );
  }
}

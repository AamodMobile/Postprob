import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/dashboard/providers/dashboard_provider.dart';
import 'package:postprob/module/login/providers/login_provider.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';
import 'package:postprob/module/sign_up/providers/sign_up_provider.dart';
import 'package:postprob/module/splash/view/splash_view.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  runApp(const MyApp());
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: OKToast(
          child: ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: false,
            useInheritedMediaQuery: true,
            child: SafeArea(
              top: false,
              left: false,
              right: false,
              child: MaterialApp(
                title: 'Postprob',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
                  useMaterial3: true,
                ),
                home: const SplashView(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

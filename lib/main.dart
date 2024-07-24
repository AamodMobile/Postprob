import 'dart:io';

import 'package:oktoast/oktoast.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/add_project/providers/add__post_provider.dart';
import 'package:postprob/module/chat/providers/chat_list_provider.dart';
import 'package:postprob/module/connection/providers/connection_provider.dart';
import 'package:postprob/module/dashboard/providers/dashboard_provider.dart';
import 'package:postprob/module/edit_profile/providers/edit_profile_provider.dart';
import 'package:postprob/module/forgot_password/providers/forgot_password_provider.dart';
import 'package:postprob/module/home/providers/home_provider.dart';
import 'package:postprob/module/login/providers/login_provider.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';
import 'package:postprob/module/save/providers/save_providers.dart';
import 'package:postprob/module/settings/providers/setting_provider.dart';
import 'package:postprob/module/sign_up/providers/sign_up_provider.dart';
import 'package:postprob/module/splash/view/splash_view.dart';
import 'package:postprob/module/your_application/providers/applied_job_provider.dart';
import 'package:postprob/module/your_post_application/providers/post_application_provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        ChangeNotifierProvider(create: (_) => SettingProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ConnectionProvider()),
        ChangeNotifierProvider(create: (_) => SavePostProvider()),
        ChangeNotifierProvider(create: (_) => AddPostProvider()),
        ChangeNotifierProvider(create: (_) => AppliedJobProvider()),
        ChangeNotifierProvider(create: (_) => PostApplicationProvider()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
        ChangeNotifierProvider(create: (_) => ChatListProvider()),
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

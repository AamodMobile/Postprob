import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oktoast/oktoast.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/helper/firebase_options.dart';
import 'package:postprob/helper/notification_helper.dart';
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
import 'package:postprob/services/api_logs.dart';
import 'package:rxdart/rxdart.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject = BehaviorSubject<String?>();

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

Future<void> backgroundHandler(RemoteMessage message) async {
  Log.console('main.dart backgroundHandler');
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Log.console('Got a message whilst in the foreground!');
    Log.console('Message data: ${message.data}');
    if (message.notification != null) {
      Log.console('Message also contained a notification: ${message.notification}');
    }
  });

  var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationSubject.add(ReceivedNotification(id: id, title: title, body: body, payload: payload));
    },
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    if (payload != null && payload.toString() != reminder) {
    } else if (payload != null && payload.toString() == reminder) {}
    selectedNotificationPayload = payload.toString();
    selectNotificationSubject.add(payload as String?);
  });

  NotificationHelper().initializeNotification();
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

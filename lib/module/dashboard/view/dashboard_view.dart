import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/helper/notification_helper.dart';
import 'package:postprob/helper/notification_listener_sevices.dart';
import 'package:postprob/helper/notification_service.dart';
import 'package:postprob/module/dashboard/providers/dashboard_provider.dart';
import 'package:postprob/module/dashboard/widgets/bottom_nav_bar.dart';
import 'package:postprob/services/api_logs.dart';

class DashboardView extends StatefulWidget {
  final int index;

  const DashboardView({super.key, required this.index});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    Provider.of<DashboardProvider>(context, listen: false).navigateToFirstIndex(widget.index);
    updateFcm();
    NotificationListenerProvider().getMessage();
    NotificationListenerProvider().getBackGroundMessage();
    NotificationService.initialize(flutterLocalNotificationsPlugin);
    NotificationHelper().initializeNotification();
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        Log.console('FirebaseMessaging.instance.getInitialMessage');
        if (message != null) {
          Log.console('New Notification');
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (message) {
        Log.console('FirebaseMessaging.onMessage.listen');
        if (message.notification != null) {
          Log.console(message.notification!.title);
          Log.console(message.notification!.body);
          Log.console("message.data11 ${message.data}");
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        Log.console("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          Log.console(message.notification!.title);
          Log.console(message.notification!.body);
          Log.console("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, state, child) {
      return WillPopScope(
        onWillPop: () async {
          final dashboardProvider = context.read<DashboardProvider>();
          return dashboardProvider.onWillPop(context);
        },
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: LayoutBuilder(
              builder: (context, constraints) {
                // Calculate the height offset based on 10 units below the bottom
                final heightOffset = (constraints.maxHeight + 10) / constraints.maxHeight;
                return AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    final slideTransition = Tween<Offset>(
                      begin: Offset(0.0, heightOffset),
                      end: Offset.zero,
                    ).animate(animation);

                    final fadeTransition = Tween<double>(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(animation);

                    return FadeTransition(
                      opacity: fadeTransition,
                      child: SlideTransition(
                        position: slideTransition,
                        child: child,
                      ),
                    );
                  },
                  child: IndexedStack(
                    key: ValueKey<int>(state.baseActiveBottomIndex),
                    index: state.baseActiveBottomIndex,
                    children: state.baseWidgets,
                  ),
                );
              },
            ),
            bottomNavigationBar: const CommonBottomNavBar(),
          ),
        ),
      );
    });
  }

  void updateFcm() async {
    final dashboardProvider = context.read<DashboardProvider>();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then(
      (token) async {
        if (token != null) {
          var fcmToken = token.toString();
          Log.console("fcm=$fcmToken");
          dashboardProvider.updateFcmTokenApi(fcmToken, context);
        }
      },
    );
  }
}

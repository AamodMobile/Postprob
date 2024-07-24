import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/module/forgot_password/view/successfully_update.dart';
import 'package:postprob/module/login/view/login_view.dart';

class CheckMailView extends StatefulWidget {
  const CheckMailView({super.key});

  @override
  State<CheckMailView> createState() => _CheckMailViewState();
}

class _CheckMailViewState extends LifecycleAwareState<CheckMailView> {
  Future<void> _openGmailApp() async {
    const intent = AndroidIntent(
      action: 'android.intent.action.MAIN',
      category: 'android.intent.category.APP_EMAIL',
      package: 'com.google.android.gm',
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    await intent.launch();
    setShouldHandleResume(true);
  }

  @override
  void onAppResume() {
    // Navigate to the next screen
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SuccessFullyUpdateView()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.97),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.04),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                "Check Your Email",
                style: TextStyle(
                  color: blackCl,
                  fontFamily: semiBold,
                  fontSize: 30.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.01),
                child: Text(
                  "We have sent the reset password to the email address brandonelouis@gmial.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: blackCl,
                    fontFamily: regular,
                    fontSize: 12.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Image.asset(undrawMessageSentImg, height: MediaQuery.of(context).size.height * 0.15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                child: CustomButtonWidget(
                  onPressed: () {
                    _openGmailApp();
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => const SuccessFullyUpdateView()));
                  },
                  text: "Open Your Email",
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.030),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                child: CustomButtonWidget(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginView()));
                  },
                  text: "Back to Login",
                  style: CustomButtonStyle.style2,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              GestureDetector(
                onTap: () {},
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: medium,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: smallTextCl,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: "You have not received the email? ",
                      ),
                      TextSpan(
                        text: 'Resend',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: medium,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: yellowDark,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

abstract class LifecycleAwareState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {
  bool _shouldHandleResume = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _shouldHandleResume) {
      onAppResume();
    }
  }

  void onAppResume();

  void setShouldHandleResume(bool value) {
    setState(() {
      _shouldHandleResume = value;
    });
  }
}

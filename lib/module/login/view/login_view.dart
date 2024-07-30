import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_check_box.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/forgot_password/view/forgot_password.dart';
import 'package:postprob/module/login/providers/login_provider.dart';
import 'package:postprob/module/sign_up/view/sign_up_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool? isCheck = false;
  late final LoginProvider loginProvider;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    loginProvider = context.read<LoginProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, state, child) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0.97),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.04),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    Text(
                      "Welcome Back",
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
                        "We're excited to have you back with us and can't wait to hear about your latest adventures",
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
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                    CustomTextField(
                      labelText: "Email",
                      hintText: "Email",
                      fillColor: Colors.white,
                      controller: state.emailController,
                      validator: state.emailValidator,
                      txKeyboardType: TextInputType.emailAddress,
                      onChanged: (v) {
                        state.emailUpdate(v);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    CustomTextField(
                      labelText: "Password",
                      hintText: "Password",
                      fillColor: Colors.white,
                      obscureText: state.isHide,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "enter password";
                        }
                        return null;
                      },
                      onChanged: (v) {
                        state.passwordUpdate(v);
                      },
                      leading1: GestureDetector(
                        onTap: () {
                          if (state.isHide) {
                            state.isShow(false);
                          } else {
                            state.isShow(true);
                          }
                        },
                        child: Image.asset(
                          state.isHide ? phEyeIc : iconEyeHideIc,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.020,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            LabeledCheckbox(
                              label: '',
                              value: isCheck!,
                              onChanged: (v) {
                                setState(() {
                                  isCheck = v;
                                });
                              },
                            ),
                            SizedBox(width: 15.w),
                            Text(
                              "Remember me",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: hintColor,
                                fontFamily: medium,
                                fontSize: 12.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, createRightToLeftRoute(const ForgotPasswordView()));
                          },
                          child: Text(
                            "Forgot Password ?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: blackCl,
                              fontFamily: semiBold,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.040,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                      child: CustomButtonWidget(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            state.loginApiCall(context);
                          }
                        },
                        text: "LOGIN",
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.030,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                      child: CustomButtonWidget(
                        onPressed: () {
                          state.signInWithGoogle();
                        },
                        text: "Sign in with Google",
                        style: CustomButtonStyle.style2,
                        iconWidget: Image.asset(
                          googleIc,
                          height: 20.h,
                          width: 16.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.030,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpView()));
                      },
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
                              text: "You don't have an account yet? ",
                            ),
                            TextSpan(
                              text: 'Sign up',
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
          ),
        ),
      );
    });
  }
}

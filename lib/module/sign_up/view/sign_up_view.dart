import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_check_box.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/login/view/login_view.dart';
import 'package:postprob/module/sign_up/providers/sign_up_provider.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool? isCheck = false;
  late final SignUpProvider signUpProvider;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    signUpProvider = context.read<SignUpProvider>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(builder: (context, state, child) {
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
                        "Create an Account",
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
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
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
                        labelText: "Full name",
                        fillColor: Colors.white,
                        validator: (v){
                          if(v!.isEmpty){
                            return "Enter name";
                        }
                        return null;
                        },
                        onChanged: (v) {
                          state.nameUpdate(v);
                        },

                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      CustomTextField(
                        labelText: "Email",
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
                        fillColor: Colors.white,
                        validator: (v){
                          if(v!.isEmpty){
                            return "Enter password";
                          }
                          return null;
                        },
                        onChanged: (v) {
                          state.passwordUpdate(v);
                        },
                        leading1: Image.asset(
                          iconEyeHideIc,
                          height: 24.h,
                          width: 24.w,
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
                          Text(
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
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.040,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                        child: CustomButtonWidget(onPressed: () {
                          if (formKey.currentState!.validate()) {
                            state.registerApiCall(context);
                          }
                        }, text: "Sign up"),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.030,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                        child: CustomButtonWidget(
                          onPressed: () {},
                          text: "Sign up with Google",
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
                        onTap: (){
                          Navigator.pop(context);
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
                                text: "You have already an account? ",
                              ),
                              TextSpan(
                                text: 'Sign in',
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
      }
    );
  }
}

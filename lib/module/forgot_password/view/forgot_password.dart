import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/forgot_password/providers/forgot_password_provider.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late ForgotPasswordProvider forgotPasswordProvider;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    forgotPasswordProvider = context.read<ForgotPasswordProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordProvider>(
      builder: (context, state, child) {
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
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Text(
                        "Forgot Password?",
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
                          "To reset your password, you need your email or mobile number that can be authenticated",
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
                      Image.asset(forgotPasswordImg, height: MediaQuery.of(context).size.height * 0.15),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
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
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                        child: CustomButtonWidget(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              state.forgetPasswordApiCall(context);
                            }
                          },
                          text: "Reset Password",
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.030,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                        child: CustomButtonWidget(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: "Back to Login",
                          style: CustomButtonStyle.style2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

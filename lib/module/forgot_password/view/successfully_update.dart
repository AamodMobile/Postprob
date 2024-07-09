import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/module/login/view/login_view.dart';

class SuccessFullyUpdateView extends StatefulWidget {
  const SuccessFullyUpdateView({super.key});

  @override
  State<SuccessFullyUpdateView> createState() => _SuccessFullyUpdateViewState();
}

class _SuccessFullyUpdateViewState extends State<SuccessFullyUpdateView> {
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
                "Successfully",
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
                  "Your password has been updated, please change your password regularly to avoid this happening",
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
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginView()));
                  },
                  text: "Continue",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.030,
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}

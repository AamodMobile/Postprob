import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/login/view/login_view.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Postprob",
                  style: TextStyle(
                    color: blackCl,
                    fontFamily: semiBold,
                    fontSize: 18.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              Image.asset(
                introImg,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.36,
              ),
              SizedBox(height: 78.h),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  textScaleFactor: 0.8,
                  text: TextSpan(
                    spellOut: true,
                    text: "Post You \n",
                    style: TextStyle(
                      color: blackCl,
                      fontFamily: semiBold,
                      fontSize: 40.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                        text: "Any Problem \n",
                        style: TextStyle(color: yellowDark, fontFamily: semiBold, fontSize: 40.sp, fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, decoration: TextDecoration.underline),
                      ),
                      TextSpan(
                        text: "Here!",
                        style: TextStyle(
                          color: blackCl,
                          fontFamily: semiBold,
                          fontSize: 40.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                "Explore all the most exciting problems based on your interest and study major.",
                style: TextStyle(
                  color: blackCl,
                  fontFamily: semiBold,
                  fontSize: 14.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context, createRightToLeftRoute(const LoginView()), (route) => false);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
                    height: 65.h,
                    width: 65.w,
                    decoration: const BoxDecoration(color: mainColor, shape: BoxShape.circle),
                    child: Image.asset(arrowForwardIc),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}

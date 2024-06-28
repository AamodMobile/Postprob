import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/route_animation.dart';
import 'package:postprob/module/dashboard/view/dashboard_view.dart';

class SuccessfulApplyView extends StatefulWidget {
  const SuccessfulApplyView({super.key});

  @override
  State<SuccessfulApplyView> createState() => _SuccessfulApplyViewState();
}

class _SuccessfulApplyViewState extends State<SuccessfulApplyView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgCl,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: bgCl,
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SizedBox(
              width: 30.w,
              height: 30.h,
              child: Center(
                child: Image.asset(
                  backIc,
                  height: 26,
                  width: 26.w,
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Image.asset(
                optionsIc,
                width: 24.h,
                height: 24.h,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 177.h,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 120.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(color: Color(0xFFF3F2F2)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 36.h,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                child: Text(
                                  "Need person for Business Development",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: blackCl,
                                    fontFamily: semiBold,
                                    fontSize: 16.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Google",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: blackCl,
                                          fontFamily: medium,
                                          fontSize: 16.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 7,
                                      width: 7,
                                      decoration: const BoxDecoration(color: Color(0xFF0D0140), shape: BoxShape.circle),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "California",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: blackCl,
                                          fontFamily: medium,
                                          fontSize: 16.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 7,
                                      width: 7,
                                      decoration: const BoxDecoration(color: Color(0xFF0D0140), shape: BoxShape.circle),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "1 day ago",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: blackCl,
                                          fontFamily: medium,
                                          fontSize: 16.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 94.h,
                        width: 94.w,
                        padding: EdgeInsets.all(12.w),
                        decoration: const BoxDecoration(
                          color: Color(0xFFAFECFE),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(googleIc),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.dm),
                    color: const Color.fromRGBO(63, 19, 228, 0.05),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            pdfIc,
                            height: 44.h,
                            width: 44.w,
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Jamet kudasi - CV - UI/UX Designer",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: mediumTextCl,
                                    fontFamily: regular,
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  '14 Feb 2022 at 11:30 am',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: hintColor,
                                    fontFamily: regular,
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
               Image.asset(successfullyApplyImg,height: 150.h,width: 152.w,),
              SizedBox(height: 10.h),
              Text(
                "Successful",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: blackCl,
                  fontFamily: semiBold,
                  fontSize: 16.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Congratulations, your application has been sent",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: smallTextCl,
                  fontFamily: regular,
                  fontSize: 12.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 30.h),
          ],
          ),
        ),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          decoration: const BoxDecoration(color: bgCl),
          child: Wrap(
            children: [
              Column(
                children: [
                  CustomButtonWidget(
                    style: CustomButtonStyle.style2,
                    onPressed: () {},
                    text: "OPEN PERSON CHAT NOW",
                  ),
                  SizedBox(height: 20.h),
                  CustomButtonWidget(
                    onPressed: () {
                      Navigator.push(context, createLeftToRightRoute(const DashboardView()));
                    },
                    text: "BACK TO HOME",
                  ),
                  SizedBox(height: 10.h)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

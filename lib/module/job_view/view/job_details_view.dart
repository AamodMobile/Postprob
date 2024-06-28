import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/expandable_text_widget.dart';
import 'package:postprob/core/common_widgets/route_animation.dart';
import 'package:postprob/module/job_view/view/upload_cv_view.dart';

class JobDetailsView extends StatefulWidget {
  const JobDetailsView({super.key});

  @override
  State<JobDetailsView> createState() => _JobDetailsViewState();
}

class _JobDetailsViewState extends State<JobDetailsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgCl,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70.h),
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
              SizedBox(
                height: 62.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  "Problem Description",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mediumTextCl,
                    fontFamily: semiBold,
                    fontSize: 14.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const ExpandableTextWidget(
                  text: demoString + demoString,
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  "Requirements",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mediumTextCl,
                    fontFamily: semiBold,
                    fontSize: 14.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 4,
                      width: 4,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0D0140),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        "Sed ut perspiciatis unde omnis iste natus error sit.",
                        textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false,applyHeightToLastDescent: false),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: smallTextCl,
                          fontFamily: regular,
                          fontSize: 12.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      width: 4,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0D0140),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur & adipisci velit.",
                        textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false,applyHeightToLastDescent: false),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: smallTextCl,
                          fontFamily: regular,
                          fontSize: 12.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              )
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
                    onPressed: () {
                      Navigator.push(context, createRightToLeftRoute(const UploadCVView()));
                    },
                    text: "CONTACT NOW",
                  ),
                  SizedBox(height: 27.h)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

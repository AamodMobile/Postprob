import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/expandable_text.dart';
import 'package:postprob/module/job_view/view/upload_cv_view.dart';

class PostDetailsView extends StatefulWidget {
  const PostDetailsView({super.key});

  @override
  State<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
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
                        height: 84.h,
                        width: 84.w,
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
              SizedBox(height: 15.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 5.h,
                ),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.dm)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "About us",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: blackCl,
                        fontFamily: semiBold,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                      decoration: BoxDecoration(color: yellowDark, borderRadius: BorderRadius.circular(10.dm)),
                      child: Text(
                        "Post",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: semiBold,
                          fontSize: 14.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      "PROFILE",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: blackCl,
                        fontFamily: semiBold,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.dm),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 25.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  googleIc,
                                  height: 50.h,
                                  width: 50.w,
                                ),
                              ),
                              SizedBox(width: 11.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Arnold Leonardo",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: mediumTextCl,
                                        fontFamily: medium,
                                        fontSize: 12.sp,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      children: [
                                        Image.asset(
                                          watchIc,
                                          height: 16.h,
                                          width: 16.w,
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          "21 minutes ago",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: hintColor,
                                            fontFamily: regular,
                                            fontSize: 10.sp,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "What are the characteristics of a fake job call form?",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: mediumTextCl,
                              fontFamily: medium,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          const ExpandableText(
                            demoString,
                            trimLines: 4,
                          ),
                          SizedBox(height: 15.h),
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.dm),
                                child: Image.asset(
                                  videoDemoImg,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Center(
                                  child: Image.asset(
                                    playIc,
                                    height: 46.h,
                                    width: 46.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "What's it like to work at Google?",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: mediumTextCl,
                              fontFamily: medium,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Youtube.com",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: mediumTextCl,
                              fontFamily: medium,
                              fontSize: 10.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 35.h),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.h),
                      decoration: BoxDecoration(color: const Color(0xFFece7fc), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.dm), bottomRight: Radius.circular(20.dm))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            shareIc,
                            height: 24.h,
                            width: 24.w,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "2",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: smallTextCl,
                              fontFamily: regular,
                              fontSize: 10.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 70.h),
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
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const UploadCVView()));
                    },
                    text: "CONTACT NOW",
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

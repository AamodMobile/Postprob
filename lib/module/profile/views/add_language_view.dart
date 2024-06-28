import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/module/profile/widgets/level_popup.dart';

class AddLanguageView extends StatefulWidget {
  const AddLanguageView({super.key});

  @override
  State<AddLanguageView> createState() => _AddLanguageViewState();
}

class _AddLanguageViewState extends State<AddLanguageView> {
  bool isPrimary = true;

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
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.h,
                width: MediaQuery.of(context).size.width,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Language",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: blackCl,
                      fontFamily: semiBold,
                      fontSize: 16.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.dm),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Language",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: mediumTextCl,
                              fontFamily: medium,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.dm),
                                child: Image.asset(
                                  splash,
                                  height: 30.h,
                                  width: 30.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Indonesian",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: mediumTextCl,
                                  fontFamily: semiBold,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Divider(
                      color: dividerCl,
                      height: 1.h,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Language",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: mediumTextCl,
                              fontFamily: medium,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPrimary = !isPrimary;
                            });
                          },
                          child: Image.asset(
                            isPrimary ? circleSelectIc : circleDefultIc,
                            height: 18.h,
                            width: 18.w,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 27.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.dm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Oral",
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
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return Dialog(
                              elevation: 0,
                              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24.dm),
                                ),
                              ),
                              child: const LevelPupUp(),
                            );
                          },
                        );
                      },
                      child: Text(
                        "level 10",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: hintColor,
                          fontFamily: regular,
                          fontSize: 12.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Divider(
                      color: dividerCl,
                      height: 1.h,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Written",
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
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return Dialog(
                              elevation: 0,
                              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24.dm),
                                ),
                              ),
                              child: const LevelPupUp(),
                            );
                          },
                        );
                      },
                      child: Text(
                        "Choose your speaking skill level",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: hintColor,
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
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Text(
                  "Proficiency level : 0 - Poor, 10 - Very good",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: hintColor,
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
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.w),
          decoration: const BoxDecoration(color: bgCl),
          child: Wrap(
            children: [
              Column(
                children: [
                  CustomButtonWidget(
                    onPressed: () {},
                    text: "Save".toUpperCase(),
                  ),
                  SizedBox(height: 80.h)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

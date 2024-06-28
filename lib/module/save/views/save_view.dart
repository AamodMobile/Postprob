import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/module/save/widgets/options_bottom_sheet.dart';

class SaveView extends StatefulWidget {
  const SaveView({super.key});

  @override
  State<SaveView> createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  bool isDelete=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: isDelete?null:AppBar(
        backgroundColor: const Color(0xFFF9F9F9),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title:Text(
          "Save Problem",
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: blackCl,
            fontFamily: semiBold,
            fontSize: 20.sp,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              setState(() {
                isDelete=true;
              });
            },
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 18.w),
              child: Text(
                "Delete all",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: yellowDark,
                  fontFamily: medium,
                  fontSize: 14.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 26.h,),
              isDelete?Column(
                children: [
                SizedBox(width: MediaQuery.of(context).size.width,height: 100.h),
                  Text(
                    "No Savings",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: blackCl,
                      fontFamily: medium,
                      fontSize: 16.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 48.w),
                    child: Text(
                      "You don't have any jobs saved, please find it in search to save jobs",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: smallTextCl,
                        fontFamily: regular,
                        fontSize: 12.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 54.h),
                  Image.asset(noSaveImg,height: 210.h,width: 210.w,),
                  SizedBox(height: 100.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.07),
                    child: CustomButtonWidget(
                      onPressed: () {

                      },
                      text: "FIND A PROBLEM",
                    ),
                  ),
                ],
              ):
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 15.h),
                      padding: EdgeInsets.all(15.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.dm),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                            blurRadius: 62,
                            color: Color.fromRGBO(153, 171, 198, 0.18),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40.h,
                                      width: 40.w,
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(color: Color(0xFFD6CDFE), shape: BoxShape.circle),
                                      child: Image.asset(appleIc),
                                    ),
                                    SizedBox(height: 10.h,),
                                    Text(
                                      "Business Development",
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: blackCl,
                                        fontFamily: medium,
                                        fontSize: 14.sp,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "Google inc . California, USA",
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: smallTextCl,
                                        fontFamily: regular,
                                        fontSize: 12.sp,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              GestureDetector(
                                onTap: (){
                                  OptionsSheet.show(context);
                                },
                                child: Image.asset(
                                  optionsIc,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:20.h,),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0xFFf5f4f6),
                                  ),
                                  child: Text(
                                    "Design",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: smallTextCl,
                                      fontFamily: regular,
                                      fontSize: 10.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0xFFf5f4f6),
                                  ),
                                  child: Text(
                                    "Full time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: smallTextCl,
                                      fontFamily: regular,
                                      fontSize: 10.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0xFFf5f4f6),
                                  ),
                                  child: Text(
                                    "Senior designer",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: smallTextCl,
                                      fontFamily: regular,
                                      fontSize: 10.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:20.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "25 minute ago",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: smallTextCl,
                                  fontFamily: regular,
                                  fontSize: 10.sp,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: medium,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    color: blackCl,
                                  ),
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text: "\$15K",
                                    ),
                                    TextSpan(
                                      text: '/Mon',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: regular,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        color: hintColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
          
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/your_application/views/your_application_view.dart';

class OptionsSheet {
  static show(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.dm),
              ),
              child: Wrap(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        width: 30.w,
                        height: 3.h,
                        decoration: BoxDecoration(color: Color(0xFF5B5858), borderRadius: BorderRadius.circular(3.dm)),
                      ),
                      SizedBox(height: 50.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          children: [
                            Image.asset(
                              sendIc,
                              height: 24.h,
                              width: 24.w,
                            ),
                            SizedBox(width: 15.w),
                            Text(
                              "Send message",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: mediumTextCl,
                                fontFamily: medium,
                                fontSize: 14.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          children: [
                            Image.asset(
                              shareIc,
                              height: 24.h,
                              width: 24.w,
                            ),
                            SizedBox(width: 15.w),
                            Text(
                              "Shared",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: mediumTextCl,
                                fontFamily: medium,
                                fontSize: 14.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          children: [
                            Image.asset(
                              deleteIc,
                              height: 24.h,
                              width: 24.w,
                            ),
                            SizedBox(width: 15.w),
                            Text(
                              "Delete",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: mediumTextCl,
                                fontFamily: medium,
                                fontSize: 14.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 13.h),
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(6)
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                circleDoneIc,
                                height: 24.h,
                                width: 24.w,
                              ),
                              SizedBox(width: 15.w),
                              Text(
                                "Apply",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: medium,
                                  fontSize: 14.sp,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

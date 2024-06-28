import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/module/login/view/login_view.dart';

class UndoChangesSheet {
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
                      Text(
                        "Undo Changes ?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: mediumTextCl,
                          fontFamily: medium,
                          fontSize: 16.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 11.h),
                      Text(
                        "Are you sure you want to change what you entered?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: smallTextCl,
                          fontFamily: regular,
                          fontSize: 14.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 45.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: CustomButtonWidget(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: "Continue Filling".toUpperCase(),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: CustomButtonWidget(
                          style: CustomButtonStyle.style2,
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          text: "Undo Changes".toUpperCase(),
                        ),
                      ),
                      SizedBox(height: 30.h),
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

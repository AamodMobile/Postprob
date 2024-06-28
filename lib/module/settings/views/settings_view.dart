import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/settings/widgets/logout_bottom_sheet.dart';
import 'package:postprob/module/update_password/views/update_password_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isSwitched = false;

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
              Text(
                "Settings",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: blackCl,
                  fontFamily: semiBold,
                  fontSize: 16.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 62,
                      spreadRadius: 0,
                      color: Color.fromRGBO(153, 171, 198, 0.18),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Image.asset(
                      bellIc,
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Text(
                      "Notifications",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: mediumTextCl,
                        fontFamily: medium,
                        fontSize: 12.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      removeLeft: true,
                      removeRight: true,
                      child: Transform.scale(
                        alignment: Alignment.centerRight,
                        scale: 0.7,
                        child: CupertinoSwitch(
                          value: _isSwitched,
                          onChanged: (value) {
                            setState(() {
                              _isSwitched = value;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const UpdatePasswordView()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 62,
                        spreadRadius: 0,
                        color: Color.fromRGBO(153, 171, 198, 0.18),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        lockIc,
                        height: 24.h,
                        width: 24.w,
                      ),
                      SizedBox(
                        width: 11.w,
                      ),
                      Text(
                        "Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: mediumTextCl,
                          fontFamily: medium,
                          fontSize: 12.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        arrowForwordIc,
                        height: 12.h,
                        width: 12.w,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  LogoutSheet.show(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 62,
                        spreadRadius: 0,
                        color: Color.fromRGBO(153, 171, 198, 0.18),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        logoutIc,
                        height: 24.h,
                        width: 24.w,
                      ),
                      SizedBox(
                        width: 11.w,
                      ),
                      Text(
                        "Logout",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: mediumTextCl,
                          fontFamily: medium,
                          fontSize: 12.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      Image.asset(
                        arrowForwordIc,
                        height: 12.h,
                        width: 12.w,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

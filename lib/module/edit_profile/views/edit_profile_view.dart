import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/settings/views/settings_view.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  String gender = "";
  FocusNode phone = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgCl,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage(profileCardBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                demoUser,
                                height: 40.h,
                                width: 40.w,
                              ),
                            ),
                            SizedBox(height: 7.h),
                            Text(
                              "Orlando Diggs",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: medium,
                                fontSize: 14.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "California, USA",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: regular,
                                fontSize: 12.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>const SettingsView()));
                            },
                            child: Image.asset(
                              settingIc,
                              height: 24.h,
                              width: 24.w,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                        decoration: BoxDecoration(color: const Color(0xFF2e1f6d), borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          children: [
                            SizedBox(width: 5.w),
                            Text(
                              "Change image",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: regular,
                                fontSize: 12.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 5.w),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      hintText: "Fullname",
                      labelText: "Fullname",
                    ),
                    SizedBox(height: 15.h),
                    CustomTextField(
                      hintText: "06 August 1992",
                      labelText: "Date of birth",
                      leading1: Icon(
                        Icons.calendar_month,
                        size: 24.sp,
                        color: mediumTextCl,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    const Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0D0140),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                gender = "male";
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
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
                                    gender == "male" ? circleSelectIc : circleDefultIc,
                                    height: 18.h,
                                    width: 18.w,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    "Male",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: medium,
                                      color: smallTextCl,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                gender = "female";
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
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
                                    gender == "female" ? circleSelectIc : circleDefultIc,
                                    height: 18.h,
                                    width: 18.w,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    "Female",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: medium,
                                      color: smallTextCl,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    CustomTextField(
                      hintText: "Email address",
                      labelText: "Email address",
                    ),
                    SizedBox(height: 15.h),
                    CustomTextField(
                      hintText: "Phone number",
                      labelText: "Phone number",
                    ),
                    SizedBox(height: 15.h),
                    Visibility(
                      visible: false,
                      child: CustomTextField(
                        hintText: "Location",
                        labelText: "Location",
                        readOnly: true,
                      ),
                    ),
                    SizedBox(height: 100.h)
                  ],
                ),
              ),
            ),
          )
        ],
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
                  text: "SAVE".toUpperCase(),
                ),
                SizedBox(height: 20.h)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

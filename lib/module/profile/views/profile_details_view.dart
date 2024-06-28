import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/edit_profile/views/edit_profile_view.dart';
import 'package:postprob/module/profile/views/add_about_view.dart';
import 'package:postprob/module/profile/views/add_documents_view.dart';
import 'package:postprob/module/profile/views/add_education_view.dart';
import 'package:postprob/module/profile/views/add_skill_view.dart';
import 'package:postprob/module/profile/views/add_work_experience_view.dart';
import 'package:postprob/module/profile/views/language_list_view.dart';
import 'package:postprob/module/settings/views/settings_view.dart';
import 'package:postprob/module/your_application/views/my_application_apply_list_view.dart';

class ProfileDetailsView extends StatefulWidget {
  final String title;
  const ProfileDetailsView({super.key, required this.title});

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView> {
  String title="";
  @override
  void initState() {
    setState(() {
      title=widget.title;
    });
    super.initState();
  }
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
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsView()));
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
                      RichText(
                          text: TextSpan(
                              text: "120k ",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: medium,
                                fontSize: 14.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                              ),
                              children: [
                            TextSpan(
                              text: "Posts",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: medium,
                                fontSize: 12.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ])),
                      RichText(
                          text: TextSpan(
                              text: "120k ",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: medium,
                                fontSize: 14.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                              ),
                              children: [
                            TextSpan(
                              text: "Posts",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: medium,
                                fontSize: 12.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ])),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileView()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                          decoration: BoxDecoration(color: const Color(0xFF2e1f6d), borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            children: [
                              SizedBox(width: 5.w),
                              Text(
                                "Edit profile",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: regular,
                                  fontSize: 12.sp,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Image.asset(editIc, height: 24.h, width: 24.w)
                            ],
                          ),
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          title="About me";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.dm),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  userCircleIc,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "About me",
                                  style: TextStyle(
                                    color: mediumTextCl,
                                    fontFamily: medium,
                                    fontSize: 14.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                   setState(() {
                                     title="About me";
                                   });
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AddAboutView()));
                                  },
                                  child: Image.asset(
                                    editIc,
                                    height: 24.h,
                                    width: 24.w,
                                    color: yellowDark,
                                  ),
                                ),
                              ],
                            ),
                            title=="About me"?Column(
                              children: [
                                SizedBox(height: 20.h),
                                Divider(color: dividerCl, height: 1.h),
                                SizedBox(height: 20.h),
                                Text(
                                  demoString,
                                  style: TextStyle(
                                    color: smallTextCl,
                                    fontFamily: regular,
                                    fontSize: 14.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ):const SizedBox()

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          title="Work experience";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.dm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  workExperienceIc,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Work experience",
                                  style: TextStyle(
                                    color: mediumTextCl,
                                    fontFamily: medium,
                                    fontSize: 14.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      title="Work experience";
                                    });
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AddWorkExperienceView()));
                                  },
                                  child: Image.asset(
                                    addCircleIc,
                                    height: 24.h,
                                    width: 24.w,
                                  ),
                                ),
                              ],
                            ),
                            title=="Work experience"?Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.h),
                                Divider(color: dividerCl, height: 1.h),
                                SizedBox(height: 20.h),
                                Row(
                                  children: [
                                    Text(
                                      "Manager",
                                      style: TextStyle(
                                        color: mediumTextCl,
                                        fontFamily: medium,
                                        fontSize: 14.sp,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      child: Image.asset(
                                        editIc,
                                        height: 24.h,
                                        width: 24.w,
                                        color: yellowDark,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Amazon Inc",
                                  style: TextStyle(
                                    color: smallTextCl,
                                    fontFamily: regular,
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Jan 2015 - Feb 2022 , 5 Years",
                                  style: TextStyle(
                                    color: smallTextCl,
                                    fontFamily: regular,
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ):const SizedBox()

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          title="Education";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.dm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  educationIc,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Education",
                                  style: TextStyle(
                                    color: mediumTextCl,
                                    fontFamily: medium,
                                    fontSize: 14.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      title="Education";
                                    });
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AddEducationView()));
                                  },
                                  child: Image.asset(
                                    addCircleIc,
                                    height: 24.h,
                                    width: 24.w,
                                  ),
                                ),
                              ],
                            ),
                            title=="Education"?Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.h),
                                Divider(color: dividerCl, height: 1.h),
                                SizedBox(height: 20.h),
                                Row(
                                  children: [
                                    Text(
                                      "Information Technology",
                                      style: TextStyle(
                                        color: mediumTextCl,
                                        fontFamily: medium,
                                        fontSize: 14.sp,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      child: Image.asset(
                                        editIc,
                                        height: 24.h,
                                        width: 24.w,
                                        color: yellowDark,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "University of Oxford",
                                  style: TextStyle(
                                    color: smallTextCl,
                                    fontFamily: regular,
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Sep 2010 - Aug 2013 , 3 Years",
                                  style: TextStyle(
                                    color: smallTextCl,
                                    fontFamily: regular,
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ):const SizedBox()

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          title="Skill";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.dm),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  skillIc,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Skill",
                                  style: TextStyle(
                                    color: mediumTextCl,
                                    fontFamily: medium,
                                    fontSize: 14.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      title="Skill";
                                    });
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AddSkillView()));
                                  },
                                  child: Image.asset(
                                    editIc,
                                    height: 24.h,
                                    width: 24.w,
                                    color: yellowDark,
                                  ),
                                ),
                              ],
                            ),
                            title=="Skill"?Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.h),
                                Divider(color: dividerCl, height: 1.h),
                                SizedBox(height: 20.h),
                                Wrap(
                                  spacing: 10.w, // Horizontal spacing between items
                                  runSpacing: 10.h, // Vertical spacing between lines
                                  children: List.generate(6, (index) {
                                    return index == 5
                                        ? Container(
                                      width: (MediaQuery.of(context).size.width - 40.w) / 3.9,
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                      child: Text(
                                        "+5 more",
                                        style: TextStyle(
                                          color: mediumTextCl,
                                          fontFamily: regular,
                                          fontSize: 12.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )
                                        : Container(
                                      width: (MediaQuery.of(context).size.width - 40.w) / 3.9,
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFf5f4f6),
                                        borderRadius: BorderRadius.circular(10.dm),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Leadership",
                                          style: TextStyle(
                                            color: mediumTextCl,
                                            fontFamily: regular,
                                            fontSize: 12.sp,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                SizedBox(height: 30.h),
                                Text(
                                  "See more",
                                  style: TextStyle(
                                    color: blueLight,
                                    fontFamily: medium,
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ):const SizedBox()

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          title="Language";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.dm),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  languageIc,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Language",
                                  style: TextStyle(
                                    color: mediumTextCl,
                                    fontFamily: medium,
                                    fontSize: 14.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      title="Language";
                                    });
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => const LanguageListView()));
                                  },
                                  child: Image.asset(
                                    editIc,
                                    height: 24.h,
                                    width: 24.w,
                                    color: yellowDark,
                                  ),
                                ),
                              ],
                            ),
                            title=="Language"?Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.h),
                                Divider(color: dividerCl, height: 1.h),
                                SizedBox(height: 20.h),
                                Wrap(
                                  spacing: 10.w, // Horizontal spacing between items
                                  runSpacing: 10.h, // Vertical spacing between lines
                                  children: List.generate(5, (index) {
                                    return IntrinsicWidth(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFf5f4f6),
                                          borderRadius: BorderRadius.circular(10.dm),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "English",
                                            style: TextStyle(
                                              color: mediumTextCl,
                                              fontFamily: regular,
                                              fontSize: 12.sp,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ):const SizedBox()

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    contColumn(languageIc, "Documents", () => Navigator.push(context, MaterialPageRoute(builder: (_)=>const AddDocumentsView()))),
                    contColumn(workExperienceIc, "My Posted Problems", () => Navigator.push(context, MaterialPageRoute(builder: (_)=>const MyApplyApplicationListView()))),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget contColumn(String image, String name, Function() onClick) {
    return Column(
      children: [
        GestureDetector(
          onTap: onClick,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.dm),
            ),
            child: Row(
              children: [
                Image.asset(
                  image,
                  height: 24.h,
                  width: 24.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: mediumTextCl,
                    fontFamily: medium,
                    fontSize: 14.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onClick,
                  child: Image.asset(
                    addCircleIc,
                    height: 24.h,
                    width: 24.w,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/edit_profile/views/edit_profile_view.dart';
import 'package:postprob/module/profile/views/add_documents_view.dart';
import 'package:postprob/module/profile/views/profile_details_view.dart';
import 'package:postprob/module/settings/views/settings_view.dart';
import 'package:postprob/module/your_application/views/my_application_apply_list_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
                              Navigator.push(context, createRightToLeftRoute(const SettingsView()));
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
                    contColumn(
                        userCircleIc,
                        "About me",
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProfileDetailsView(
                                      title: 'About me',
                                    )))),
                    contColumn(
                        workExperienceIc,
                        "Work experience",
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProfileDetailsView(
                                      title: 'Work experience',
                                    )))),
                    contColumn(
                        educationIc,
                        "Education",
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProfileDetailsView(
                                      title: 'Education',
                                    )))),
                    contColumn(
                        skillIc,
                        "Skill",
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProfileDetailsView(
                                      title: 'Skill',
                                    )))),
                    contColumn(
                        languageIc,
                        "Language",
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProfileDetailsView(
                                      title: 'Language',
                                    )))),
                    contColumn(languageIc, "Documents", () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddDocumentsView()))),
                    contColumn(workExperienceIc, "My Posted Problems", () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyApplyApplicationListView()))),
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

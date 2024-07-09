import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/edit_profile/views/edit_profile_view.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';
import 'package:postprob/module/profile/views/add_about_view.dart';
import 'package:postprob/module/profile/views/add_documents_view.dart';
import 'package:postprob/module/profile/views/add_education_view.dart';
import 'package:postprob/module/profile/views/add_skill_view.dart';
import 'package:postprob/module/profile/views/add_work_experience_view.dart';
import 'package:postprob/module/profile/views/language_list_view.dart';
import 'package:postprob/module/settings/views/settings_view.dart';
import 'package:postprob/module/your_application/views/my_application_apply_list_view.dart';
import 'package:postprob/module/your_post_application/views/post_application_list_view.dart';
import 'package:postprob/services/api_url.dart';

class ProfileDetailsView extends StatefulWidget {
  final String title;

  const ProfileDetailsView({super.key, required this.title});

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView> {
  String title = "";
  late ProfileProvider profileProvider;

  @override
  void initState() {
    profileProvider = context.read<ProfileProvider>();
    profileProvider.userGetProfile(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, state, child) {
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
                                  borderRadius: BorderRadius.circular(20.dm),
                                  child: state.profileModel.image != ""
                                      ? CachedNetworkImage(
                                          errorWidget: (context, url, error) => Image.asset(
                                            demoUser,
                                            height: 40.h,
                                            width: 40.w,
                                            fit: BoxFit.cover,
                                          ),
                                          height: 40.h,
                                          width: 40.w,
                                          fit: BoxFit.cover,
                                          imageUrl: ApiUrl.imageUrl + state.profileModel.image.toString(),
                                          placeholder: (a, b) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : Image.asset(
                                          demoUser,
                                          height: 40.h,
                                          width: 40.w,
                                        ),
                                ),
                                SizedBox(height: 7.h),
                                Text(
                                  state.profileModel.name ?? "",
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
                                  state.profileModel.cityId ?? "",
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
                              Navigator.push(context, createRightToLeftRoute(const EditProfileView()));
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
                          onTap: () {
                            setState(() {
                              title = "About me";
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
                                          title = "About me";
                                        });
                                        if (state.profileModel.aboutMe != null && state.profileModel.aboutMe != "") {
                                          Navigator.push(
                                              context,
                                              createRightToLeftRoute(AddAboutView(
                                                about: state.profileModel.aboutMe.toString(),
                                              )));
                                        } else {
                                          Navigator.push(
                                              context,
                                              createRightToLeftRoute(const AddAboutView(
                                                about: "",
                                              )));
                                        }
                                      },
                                      child: Image.asset(
                                        state.profileModel.aboutMe != "" ? editIc : addCircleIc,
                                        height: 24.h,
                                        width: 24.w,
                                        color: yellowDark,
                                      ),
                                    ),
                                  ],
                                ),
                                if (state.profileModel.aboutMe != "")
                                  title == "About me"
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20.h),
                                            Divider(color: dividerCl, height: 1.h),
                                            SizedBox(height: 20.h),
                                            Text(
                                              state.profileModel.aboutMe ?? "",
                                              style: TextStyle(
                                                color: smallTextCl,
                                                fontFamily: regular,
                                                fontSize: 14.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              title = "Work experience";
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
                                          title = "Work experience";
                                        });
                                        Navigator.push(context, createRightToLeftRoute(AddWorkExperienceView(isEdit: false, id: '')));
                                      },
                                      child: Image.asset(
                                        addCircleIc,
                                        height: 24.h,
                                        width: 24.w,
                                      ),
                                    ),
                                  ],
                                ),
                                if (state.profileModel.experience != null)
                                  title == "Work experience"
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20.h),
                                            Divider(color: dividerCl, height: 1.h),
                                            SizedBox(height: 20.h),
                                            Row(
                                              children: [
                                                Text(
                                                  state.profileModel.experience!.title.toString(),
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
                                                    Navigator.push(
                                                        context,
                                                        createRightToLeftRoute(AddWorkExperienceView(
                                                          isEdit: true,
                                                          id: state.profileModel.experience!.id.toString(),
                                                          experience: state.profileModel.experience,
                                                        )));
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
                                            SizedBox(height: 5.h),
                                            Text(
                                              state.profileModel.experience!.company.toString(),
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
                                              "${state.profileModel.experience!.startDate.toString()} - ${state.profileModel.experience!.endDate.toString()} ,${calculateDuration(state.profileModel.education!.startDate.toString(), state.profileModel.education!.endDate.toString())}",
                                              style: TextStyle(
                                                color: smallTextCl,
                                                fontFamily: regular,
                                                fontSize: 12.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              title = "Education";
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
                                          title = "Education";
                                        });
                                        Navigator.push(context, createRightToLeftRoute(AddEducationView(isEdit: false, id: '')));
                                      },
                                      child: Image.asset(
                                        addCircleIc,
                                        height: 24.h,
                                        width: 24.w,
                                      ),
                                    ),
                                  ],
                                ),
                                if (state.profileModel.education != null)
                                  title == "Education"
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20.h),
                                            Divider(color: dividerCl, height: 1.h),
                                            SizedBox(height: 20.h),
                                            Row(
                                              children: [
                                                Text(
                                                  state.profileModel.education!.educationLavel.toString(),
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
                                                    Navigator.push(
                                                        context,
                                                        createRightToLeftRoute(AddEducationView(
                                                          isEdit: true,
                                                          id: state.profileModel.education!.id.toString(),
                                                          education: state.profileModel.education,
                                                        )));
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
                                            SizedBox(height: 5.h),
                                            Text(
                                              state.profileModel.education!.institutionName.toString(),
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
                                              "${state.profileModel.education!.startDate.toString()} - ${state.profileModel.education!.endDate.toString()} ,${calculateDuration(state.profileModel.education!.startDate.toString(), state.profileModel.education!.endDate.toString())}",
                                              style: TextStyle(
                                                color: smallTextCl,
                                                fontFamily: regular,
                                                fontSize: 12.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              title = "Skill";
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
                                          title = "Skill";
                                        });
                                        if (state.profileModel.skills == null && state.profileModel.skills!.isEmpty) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => const AddSkillView(
                                                        selectedItem: [],
                                                        isEdit: false,
                                                      )));
                                        } else {
                                          Navigator.push(
                                              context,
                                              createRightToLeftRoute(AddSkillView(
                                                selectedItem: state.profileModel.skills!,
                                                isEdit: true,
                                              )));
                                        }
                                      },
                                      child: Image.asset(
                                        state.profileModel.skills != null && state.profileModel.skills!.isNotEmpty ? editIc : addCircleIc,
                                        height: 24.h,
                                        width: 24.w,
                                        color: yellowDark,
                                      ),
                                    ),
                                  ],
                                ),
                                if (state.profileModel.skills != null && state.profileModel.skills!.isNotEmpty)
                                  title == "Skill"
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20.h),
                                            Divider(color: dividerCl, height: 1.h),
                                            SizedBox(height: 20.h),
                                            Wrap(
                                              spacing: 10.w, // Horizontal spacing between items
                                              runSpacing: 10.h, // Vertical spacing between lines
                                              children: List.generate(state.profileModel.skills!.length, (index) {
                                                if (index < 5) {
                                                  return Container(
                                                    width: (MediaQuery.of(context).size.width - 40.w) / 3.9,
                                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFFf5f4f6),
                                                      borderRadius: BorderRadius.circular(10.dm),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        state.profileModel.skills![index].title.toString(),
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
                                                } else if (index == 5) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      // Handle the logic to expand and show all skills
                                                      // For example, you can update a state variable to show all skills.
                                                      // This is where you would toggle visibility of all skills.
                                                    },
                                                    child: Container(
                                                      width: (MediaQuery.of(context).size.width - 40.w) / 3.9,
                                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                                      child: Text(
                                                        "+${state.profileModel.skills!.length - 5} more",
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
                                                } else {
                                                  return Container(); // Return an empty container for items beyond index 5 initially
                                                }
                                              }),
                                            ),
                                            SizedBox(height: 30.h),
                                            GestureDetector(
                                              onTap: () {
                                                // Handle the logic to expand and show all skills
                                                // For example, navigate to a new screen or expand the list in place.
                                              },
                                              child: Text(
                                                "See more",
                                                style: TextStyle(
                                                  color: blueLight,
                                                  fontFamily: medium,
                                                  fontSize: 12.sp,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              title = "Language";
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
                                          title = "Language";
                                        });
                                        Navigator.push(context, createRightToLeftRoute(const LanguageListView()));
                                      },
                                      child: Image.asset(
                                        state.profileModel.languages != null && state.profileModel.languages!.isNotEmpty ? editIc : addCircleIc,
                                        height: 24.h,
                                        width: 24.w,
                                        color: yellowDark,
                                      ),
                                    ),
                                  ],
                                ),
                                if (state.profileModel.languages != null && state.profileModel.languages!.isNotEmpty)
                                  title == "Language"
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 20.h),
                                            Divider(color: dividerCl, height: 1.h),
                                            SizedBox(height: 20.h),
                                            Wrap(
                                              spacing: 10.w, // Horizontal spacing between items
                                              runSpacing: 10.h, // Vertical spacing between lines
                                              children: List.generate(state.profileModel.languages!.length, (index) {
                                                return IntrinsicWidth(
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFFf5f4f6),
                                                      borderRadius: BorderRadius.circular(10.dm),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        state.profileModel.languages![index].language!.title.toString(),
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
                                        )
                                      : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        contColumn(languageIc, "Documents", () => Navigator.push(context, createRightToLeftRoute(const AddDocumentsView()))),
                        contColumn(workExperienceIc, "My Posted Problems", () => Navigator.push(context, createRightToLeftRoute(const PostApplicationListView()))),
                        contColumn(workExperienceIc, "My Apply Problems", () => Navigator.push(context, createRightToLeftRoute(const MyApplyApplicationListView()))),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
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

  String calculateDuration(String startDateString, String endDateString) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    DateTime startDate = dateFormat.parse(startDateString);
    DateTime endDate = dateFormat.parse(endDateString);
    Duration difference = endDate.difference(startDate);
    int years = difference.inDays ~/ 365;
    String durationString = " $years Years";
    return durationString;
  }
}

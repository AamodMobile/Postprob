import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/module/profile/models/list_data_model.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';
import 'package:postprob/module/profile/widgets/level_popup.dart';
import 'package:postprob/services/api_url.dart';

class AddLanguageView extends StatefulWidget {
  final ListDataModel listDataModel;
  final bool isEdit;
  final String id;
  final String? oral;
  final String? writing;
  final bool? isPrimary;

  const AddLanguageView({super.key, required this.listDataModel, required this.isEdit, this.oral, this.writing,this.isPrimary, required this.id});

  @override
  State<AddLanguageView> createState() => _AddLanguageViewState();
}

class _AddLanguageViewState extends State<AddLanguageView> {
  late ProfileProvider profileProvider;

  @override
  void initState() {
    profileProvider = context.read<ProfileProvider>();
    profileProvider.reset();
    profileProvider.getLanguageLevelList(context).then((value) {
      if (widget.isEdit) {
        profileProvider.selectedLanguage = widget.listDataModel;
        profileProvider.selectedOralLevelLanguage.title = widget.oral;
        profileProvider.selectedWrittenLevelLanguage.title = widget.writing;
        profileProvider.isPrimaryLanguage = widget.isPrimary!;
        for (var c in profileProvider.languageLevelList) {
          if (c.title == profileProvider.selectedOralLevelLanguage.title) {
            profileProvider.selectedOralLevelLanguage.id = c.id;
            break;
          }
        }
        for (var c in profileProvider.languageLevelList) {
          if (c.title == profileProvider.selectedWrittenLevelLanguage.title) {
            profileProvider.selectedWrittenLevelLanguage.id = c.id;
            break;
          }
        }
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, state, child) {
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
                                  child: widget.listDataModel.image != ""
                                      ? CachedNetworkImage(
                                          errorWidget: (context, url, error) => Image.asset(
                                            koreanFlag,
                                            height: 30.h,
                                            width: 30.w,
                                            fit: BoxFit.cover,
                                          ),
                                          height: 30.h,
                                          width: 30.w,
                                          fit: BoxFit.cover,
                                          imageUrl: ApiUrl.imageUrl + widget.listDataModel.image.toString(),
                                          placeholder: (a, b) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : Image.asset(
                                          splash,
                                          height: 30.h,
                                          width: 30.w,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  widget.listDataModel.title.toString(),
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
                              "First language",
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
                              if (state.isPrimaryLanguage) {
                                state.isPrimaryLanguageSet(false);
                              } else {
                                state.isPrimaryLanguageSet(true);
                              }
                            },
                            child: Image.asset(
                              state.isPrimaryLanguage ? circleSelectIc : circleDefultIc,
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
                      SizedBox(height: 10.h),
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
                                child: LevelPupUp(
                                  profileProvider: state,
                                  isOral: true,
                                ),
                              );
                            },
                          );
                        },
                        child: SizedBox(
                          height: 40.h,
                          child: Text(
                            state.selectedOralLevelLanguage.title == "" ? "Choose your oral skill level" : state.selectedOralLevelLanguage.title.toString(),
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
                      ),
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
                            barrierDismissible: false,
                            builder: (_) {
                              return Dialog(
                                elevation: 0,
                                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24.dm),
                                  ),
                                ),
                                child: LevelPupUp(
                                  profileProvider: state,
                                  isOral: false,
                                ),
                              );
                            },
                          );
                        },
                        child: SizedBox(
                          height: 40.h,
                          child: Text(
                            state.selectedWrittenLevelLanguage.title == "" ? "Choose your speaking skill level" : state.selectedWrittenLevelLanguage.title.toString(),
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
                      ),
                    ],
                  ),
                ),
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
                      onPressed: () {
                        if (state.selectedLanguage == null) {
                          errorToast(context, "Selected Language");
                        } else if (state.selectedOralLevelLanguage.title == "") {
                          errorToast(context, "Selected Oral Level");
                        } else if (state.selectedOralLevelLanguage.title == "") {
                          errorToast(context, "Selected Written Level");
                        } else {
                          if (widget.isEdit) {
                            state.addUserLanguage(
                              context,
                              widget.id.toString(),
                              state.selectedLanguage.id.toString(),
                              state.selectedOralLevelLanguage.id.toString(),
                              state.selectedWrittenLevelLanguage.id.toString(),
                              state.isPrimaryLanguage == true ? "1" : "0",
                            );
                          } else {
                            state.addUserLanguage(
                              context,
                              "",
                              state.selectedLanguage.id.toString(),
                              state.selectedOralLevelLanguage.id.toString(),
                              state.selectedWrittenLevelLanguage.id.toString(),
                              state.isPrimaryLanguage == true ? "1" : "0",
                            );
                          }
                        }
                      },
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
    });
  }
}

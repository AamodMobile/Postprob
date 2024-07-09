import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';
import 'package:postprob/module/profile/views/add_language_view.dart';
import 'package:postprob/module/profile/views/search_language_view.dart';
import 'package:postprob/module/profile/widgets/remove_item_sheet.dart';
import 'package:postprob/services/api_url.dart';

class LanguageListView extends StatefulWidget {
  const LanguageListView({super.key});

  @override
  State<LanguageListView> createState() => _LanguageListViewState();
}

class _LanguageListViewState extends State<LanguageListView> {
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
                        "Language",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: blackCl,
                          fontFamily: semiBold,
                          fontSize: 16.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, createRightToLeftRoute(const SearchLanguageView()));
                        },
                        child: Row(
                          children: [
                            Text(
                              "Add",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: blueLight,
                                fontFamily: semiBold,
                                fontSize: 14.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Image.asset(
                              circleAddBlueIc,
                              height: 24.h,
                              width: 24.w,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.profileModel.languages?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                createRightToLeftRoute(AddLanguageView(
                                  listDataModel: state.profileModel.languages![index].language!,
                                  isEdit: true,
                                  oral: state.profileModel.languages![index].oralLavel.toString(),
                                  writing: state.profileModel.languages![index].writtenLavel.toString(), id: state.profileModel.languages![index].id.toString(),
                                )));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                            margin: EdgeInsets.only(bottom: 15.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.dm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.dm),
                                      child: state.profileModel.languages![index].language!.image != ""
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
                                              imageUrl: ApiUrl.imageUrl + state.profileModel.languages![index].language!.image.toString(),
                                              placeholder: (a, b) => const Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            )
                                          : Image.asset(
                                              hindiIndianFlag,
                                              height: 30.h,
                                              width: 30.w,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        state.profileModel.languages![index].language!.title.toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: mediumTextCl,
                                          fontFamily: semiBold,
                                          fontSize: 12.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        RemoveItemSheet.show(
                                            context, state.profileModel.languages![index].language!.title.toString(), "${state.profileModel.languages![index].language!.title.toString()} language",
                                            () {
                                          state.deleteUserLanguage(context, state.profileModel.languages![index].id.toString());
                                        });
                                      },
                                      child: Image.asset(
                                        deleteIc,
                                        height: 24.h,
                                        width: 24.w,
                                        color: redCl,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Text(
                                  state.profileModel.languages![index].oralLavel.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: hintColor,
                                    fontFamily: regular,
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  state.profileModel.languages![index].writtenLavel.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: hintColor,
                                    fontFamily: regular,
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
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
      },
    );
  }
}

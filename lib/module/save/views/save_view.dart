import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/loader_class.dart';
import 'package:postprob/module/save/providers/save_providers.dart';
import 'package:postprob/module/save/widgets/options_bottom_sheet.dart';
import 'package:postprob/services/api_url.dart';

class SaveView extends StatefulWidget {
  const SaveView({super.key});

  @override
  State<SaveView> createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  late SavePostProvider savePostProvider;

  @override
  void initState() {
    savePostProvider = context.read<SavePostProvider>();
    savePostProvider.savedPostsList(context, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SavePostProvider>(
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          appBar: state.savePostList.isEmpty
              ? null
              : AppBar(
                  backgroundColor: const Color(0xFFF9F9F9),
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  elevation: 0,
                  title: Text(
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
                      onTap: () {
                        state.removeSavedPost(context, "", "all");
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
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
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Builder(
                builder: (context) {
                  if (state.isLoading) {
                    return LoaderClass(height: MediaQuery.of(context).size.height - 200);
                  }
                  if (state.savePostList.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 26.h,
                        ),
                        Column(
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width, height: 100.h),
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
                              padding: EdgeInsets.symmetric(horizontal: 48.w),
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
                            Image.asset(
                              noSaveImg,
                              height: 210.h,
                              width: 210.w,
                            ),
                            SizedBox(height: 100.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.07),
                              child: CustomButtonWidget(
                                onPressed: () {},
                                text: "FIND A PROBLEM",
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                  return Column(
                    children: [
                      SizedBox(
                        height: 26.h,
                      ),
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: state.savePostList.length,
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
                                              padding: const EdgeInsets.all(5),
                                              decoration: const BoxDecoration(color: Color(0xFFD6CDFE), shape: BoxShape.circle),
                                              child: state.savePostList[index].user!.image != ""
                                                  ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(20.dm),
                                                  child:CachedNetworkImage(
                                                      errorWidget: (context, url, error) => Image.asset(
                                                        demoUser,
                                                        height: 40.h,
                                                        width: 40.w,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      height: 40.h,
                                                      width: 40.w,
                                                   fit: BoxFit.cover,
                                                      imageUrl: ApiUrl.imageUrl + state.savePostList[index].user!.image.toString(),
                                                      placeholder: (a, b) => const Center(
                                                        child: CircularProgressIndicator(),
                                                      ),
                                                    ),)
                                                  : Image.asset(appleIc),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              state.savePostList[index].title.toString(),
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
                                        onTap: () {
                                          OptionsSheet.show(
                                            context,
                                            state.savePostList[index].id.toString(),
                                            () => {state.removeSavedPost(context, state.savePostList[index].id.toString(), "single")},
                                          );
                                        },
                                        child: Image.asset(
                                          optionsIc,
                                          height: 24.h,
                                          width: 24.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
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
                                            state.savePostList[index].category!.title.toString(),
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
                                            state.savePostList[index].workplace!.title.toString(),
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
                                            state.savePostList[index].city!.title.toString(),
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
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.savePostList[index].postedAt.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: smallTextCl,
                                          fontFamily: regular,
                                          fontSize: 10.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      /* RichText(
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
                                      ),*/
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

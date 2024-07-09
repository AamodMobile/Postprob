import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/expandable_text.dart';
import 'package:postprob/core/common_widgets/loader_class.dart';
import 'package:postprob/module/connection/providers/connection_provider.dart';
import 'package:postprob/module/job_view/view/upload_cv_view.dart';
import 'package:postprob/services/api_url.dart';

class PostDetailsView extends StatefulWidget {
  final String postId;

  const PostDetailsView({super.key, required this.postId});

  @override
  State<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
  late ConnectionProvider connectionProvider;

  @override
  void initState() {
    connectionProvider = context.read<ConnectionProvider>();
    connectionProvider.getPostDetails(context, widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectionProvider>(
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
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Image.asset(
                    optionsIc,
                    width: 24.h,
                    height: 24.h,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Builder(
                builder: (context) {
                  if (state.isLoading) {
                    return LoaderClass(height: MediaQuery.of(context).size.height - 200);
                  }
                  if (state.noData) {
                    return Column(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width, height: 100.h),
                        SizedBox(
                          height: 240.h,
                          width: 240.w,
                        ),
                        SizedBox(height: 42.h),
                        Text(
                          "No Post Details",
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
                          padding: EdgeInsets.symmetric(horizontal: 45.w),
                          child: Text(
                            "You currently have no post details",
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
                        SizedBox(height: 77.h),
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h),
                      SizedBox(
                        height: 177.h,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 120.h,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(color: Color(0xFFF3F2F2)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 36.h,
                                        width: MediaQuery.of(context).size.width,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                        child: Text(
                                          state.postDetailsModel.title.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: blackCl,
                                            fontFamily: semiBold,
                                            fontSize: 16.sp,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15.h),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Google",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: blackCl,
                                                  fontFamily: medium,
                                                  fontSize: 14.sp,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 7,
                                              width: 7,
                                              margin: EdgeInsets.symmetric(horizontal: 10.w),
                                              decoration: const BoxDecoration(color: Color(0xFF0D0140), shape: BoxShape.circle),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  state.postDetailsModel.city!=null?
                                                state.postDetailsModel.city!.title.toString():"",
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: blackCl,
                                                  fontFamily: medium,
                                                  fontSize: 14.sp,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 7,
                                              width: 7,
                                              margin: EdgeInsets.symmetric(horizontal: 10.w),
                                              decoration: const BoxDecoration(color: Color(0xFF0D0140), shape: BoxShape.circle),
                                            ),
                                            Expanded(
                                              child: Text(
                                                state.postDetailsModel.postedAt.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: blackCl,
                                                  fontFamily: medium,
                                                  fontSize: 14.sp,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                height: 84.h,
                                width: 84.w,
                                padding: EdgeInsets.all(10.w),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFAFECFE),
                                  shape: BoxShape.circle,
                                ),
                                child: state.postDetailsModel.user!.image != ""
                                    ? Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.dm),
                                    child: CachedNetworkImage(
                                      errorWidget: (context, url, error) => Image.asset(
                                        demoUser,
                                        height: 60.h,
                                        width: 60.w,
                                        fit: BoxFit.cover,
                                      ),
                                      height: 60.h,
                                      width: 60.w,
                                      fit: BoxFit.cover,
                                      imageUrl: ApiUrl.imageUrl + state.postDetailsModel.user!.image.toString(),
                                      placeholder: (a, b) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                )
                                    : Image.asset(googleIc),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.dm)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "About us",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: blackCl,
                                fontFamily: semiBold,
                                fontSize: 14.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                              decoration: BoxDecoration(color: yellowDark, borderRadius: BorderRadius.circular(10.dm)),
                              child: Text(
                                "Post",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: semiBold,
                                  fontSize: 14.sp,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              "PROFILE",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: blackCl,
                                fontFamily: semiBold,
                                fontSize: 14.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.dm),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 25.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(25.dm),
                                        child: state.postDetailsModel.user!.image != ""
                                            ? CachedNetworkImage(
                                                errorWidget: (context, url, error) => Image.asset(
                                                  demoUser,
                                                  height: 50.h,
                                                  width: 50.w,
                                                  fit: BoxFit.cover,
                                                ),
                                                height: 50.h,
                                                width: 50.w,
                                             fit: BoxFit.cover,
                                                imageUrl: ApiUrl.imageUrl + state.postDetailsModel.user!.image.toString(),
                                                placeholder: (a, b) => const Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                              )
                                            : Image.asset(
                                                googleIc,
                                                height: 50.h,
                                                width: 50.w,
                                              ),
                                      ),
                                      SizedBox(width: 11.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              state.postDetailsModel.user!.name.toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: mediumTextCl,
                                                fontFamily: medium,
                                                fontSize: 12.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  watchIc,
                                                  height: 16.h,
                                                  width: 16.w,
                                                ),
                                                SizedBox(width: 5.w),
                                                Text(
                                                  state.postDetailsModel.postedAt.toString(),
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: hintColor,
                                                    fontFamily: regular,
                                                    fontSize: 10.sp,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  Text(
                                    state.postDetailsModel.title.toString(),
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
                                  ExpandableText(
                                    state.postDetailsModel.description.toString(),
                                    trimLines: 4,
                                  ),
                                  SizedBox(height: 15.h),
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20.dm),
                                        child: Image.asset(
                                          videoDemoImg,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        child: Center(
                                          child: Image.asset(
                                            playIc,
                                            height: 46.h,
                                            width: 46.w,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Text(
                                    "What's it like to work at Google?",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: mediumTextCl,
                                      fontFamily: medium,
                                      fontSize: 12.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    "Youtube.com",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: mediumTextCl,
                                      fontFamily: medium,
                                      fontSize: 10.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 35.h),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20.h),
                              decoration: BoxDecoration(color: const Color(0xFFece7fc), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.dm), bottomRight: Radius.circular(20.dm))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    shareIc,
                                    height: 24.h,
                                    width: 24.w,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    state.postDetailsModel.shareCount.toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: smallTextCl,
                                      fontFamily: regular,
                                      fontSize: 10.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 70.h),
                    ],
                  );
                },
              ),
            ),
            bottomSheet: state.isLoading
                ? const SizedBox()
                : state.noData
                    ? const SizedBox()
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        decoration: const BoxDecoration(color: bgCl),
                        child: Wrap(
                          children: [
                            Column(
                              children: [
                                CustomButtonWidget(
                                  onPressed: () {
                                    if(state.postDetailsModel.isApplied==0){
                                      Navigator.push(context, createRightToLeftRoute(UploadCVView(id: widget.postId,postDetailsModel: state.postDetailsModel)));
                                    }else{
                                      successToast(context, "Already Applied");
                                    }

                                  },
                                  text: state.postDetailsModel.isApplied==0?"CONTACT NOW":"Applied".toUpperCase(),
                                ),
                                SizedBox(height: 10.h)
                              ],
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

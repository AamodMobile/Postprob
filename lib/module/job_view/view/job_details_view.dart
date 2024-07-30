import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/expandable_text_widget.dart';
import 'package:postprob/core/common_widgets/loader_class.dart';
import 'package:postprob/module/connection/providers/connection_provider.dart';
import 'package:postprob/module/job_view/view/upload_cv_view.dart';
import 'package:postprob/services/api_url.dart';

class JobDetailsView extends StatefulWidget {
  final String postId;

  const JobDetailsView({super.key, required this.postId});

  @override
  State<JobDetailsView> createState() => _JobDetailsViewState();
}

class _JobDetailsViewState extends State<JobDetailsView> {
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
                      SizedBox(height: 70.h),
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
                                            /* Expanded(
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
                                            ),*/
                                            Expanded(
                                              child: Text(
                                                state.postDetailsModel.city != null ? state.postDetailsModel.city!.title.toString() : "",
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
                                child: state.postDetailsModel.user != null && state.postDetailsModel.user!.image != ""
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
                      SizedBox(
                        height: 62.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Problem Description",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: mediumTextCl,
                            fontFamily: semiBold,
                            fontSize: 14.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ExpandableTextWidget(text: state.postDetailsModel.description.toString()),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Requirements",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: mediumTextCl,
                            fontFamily: semiBold,
                            fontSize: 14.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 4,
                              width: 4,
                              decoration: const BoxDecoration(
                                color: Color(0xFF0D0140),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                state.postDetailsModel.employmentType!.title.toString(),
                                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: smallTextCl,
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
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 4,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              width: 4,
                              decoration: const BoxDecoration(
                                color: Color(0xFF0D0140),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                state.postDetailsModel.position.toString(),
                                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: smallTextCl,
                                  fontFamily: regular,
                                  fontSize: 12.sp,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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
                                    if (state.postDetailsModel.isApplied == 0) {
                                      Navigator.push(context, createRightToLeftRoute(UploadCVView(id: widget.postId, postDetailsModel: state.postDetailsModel)));
                                    } else {
                                      successToast(context, "Already Applied");
                                    }
                                  },
                                  text: state.postDetailsModel.isApplied == 0 ? "CONTACT NOW" : "Applied".toUpperCase(),
                                ),
                                SizedBox(height: 27.h)
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/loader_class.dart';
import 'package:postprob/module/your_application/providers/applied_job_provider.dart';
import 'package:postprob/services/api_url.dart';

class YourApplicationView extends StatefulWidget {
  final String id;

  const YourApplicationView({super.key, required this.id});

  @override
  State<YourApplicationView> createState() => _YourApplicationViewState();
}

class _YourApplicationViewState extends State<YourApplicationView> {
  late AppliedJobProvider appliedJobProvider;

  @override
  void initState() {
    appliedJobProvider = context.read<AppliedJobProvider>();
    appliedJobProvider.getAppliedJobDetail(context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppliedJobProvider>(
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
              child: Builder(
                builder: (context) {
                  if (state.isLoading) {
                    return LoaderClass(height: MediaQuery.of(context).size.height - 200);
                  }
                  if (state.noData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width, height: 250.h),
                        Text(
                          "Your application",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: blackCl,
                            fontFamily: semiBold,
                            fontSize: 16.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 39.h),
                        Text(
                          "No Applied Job Details",
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
                            "no found applied job details ",
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
                      ],
                    );
                  }
                  return Column(
                    children: [
                      SizedBox(
                        height: 25.h,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Text(
                        "Your application",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: blackCl,
                          fontFamily: semiBold,
                          fontSize: 16.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 39.h),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.dm),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40.h,
                                  width: 40.w,
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(color: Color(0xFFF5F5F5), shape: BoxShape.circle),
                                  child: state.applyJobDetails.jobDetail!.image != ""
                                      ? CachedNetworkImage(
                                          errorWidget: (context, url, error) => Image.asset(
                                            appleIc,
                                            height: 40.h,
                                            width: 40.w,
                                            fit: BoxFit.contain,
                                          ),
                                          height: 40.h,
                                          width: 40.w,
                                       fit: BoxFit.cover,
                                          imageUrl: ApiUrl.imageUrl + state.applyJobDetails.jobDetail!.image.toString(),
                                          placeholder: (a, b) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : Image.asset(googleIc),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  state.applyJobDetails.jobDetail!.title.toString(),
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
                                  state.applyJobDetails.jobDetail!.city!.city.toString(),
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
                                SizedBox(height: 20.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 4,
                                      width: 4,
                                      margin: const EdgeInsets.symmetric(vertical: 5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFB5B6B7),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        state.applyJobDetails.jobDetail!.description.toString(),
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
                                SizedBox(height: 15.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 4,
                                      width: 4,
                                      margin: const EdgeInsets.symmetric(vertical: 5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFB5B6B7),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        state.applyJobDetails.jobDetail!.position.toString(),
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
                                SizedBox(height: 30.h),
                                Text(
                                  "Job details",
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
                                SizedBox(height: 21.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 4,
                                      width: 4,
                                      margin: const EdgeInsets.symmetric(vertical: 5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFB5B6B7),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        state.applyJobDetails.jobDetail!.position.toString(),
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
                                SizedBox(height: 15.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 4,
                                      width: 4,
                                      margin: const EdgeInsets.symmetric(vertical: 5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFB5B6B7),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        state.applyJobDetails.jobDetail!.employmentType!.title.toString(),
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
                                SizedBox(height: 15.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 4,
                                      width: 4,
                                      margin: const EdgeInsets.symmetric(vertical: 5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFB5B6B7),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        state.applyJobDetails.jobDetail!.title.toString(),
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
                                SizedBox(height: 30.h),
                                Text(
                                  "Application details",
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
                                SizedBox(height: 21.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 4,
                                      width: 4,
                                      margin: const EdgeInsets.symmetric(vertical: 5),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFB5B6B7),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        "CV/Resume",
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
                                SizedBox(height: 10.h),
                                DottedBorder(
                                  color: const Color(0xFF9D97B5),
                                  strokeWidth: 1,
                                  borderType: BorderType.RRect,
                                  padding: EdgeInsets.zero,
                                  radius: Radius.circular(20.dm),
                                  dashPattern: const [3, 3],
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.dm),
                                      color: const Color.fromRGBO(63, 19, 228, 0.05),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              pdfIc,
                                              height: 44.h,
                                              width: 44.w,
                                            ),
                                            SizedBox(width: 15.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.applyJobDetails.resume!.toString(),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: mediumTextCl,
                                                      fontFamily: regular,
                                                      fontSize: 12.sp,
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  Text(
                                                    state.applyJobDetails.appliedAt!.toString(),
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
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 23.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        decoration: const BoxDecoration(color: bgCl),
                        child: Wrap(
                          children: [
                            Column(
                              children: [
                                CustomButtonWidget(
                                  onPressed: () {},
                                  text: "Look at more problems".toUpperCase(),
                                ),
                                SizedBox(height: 50.h)
                              ],
                            ),
                          ],
                        ),
                      ),
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

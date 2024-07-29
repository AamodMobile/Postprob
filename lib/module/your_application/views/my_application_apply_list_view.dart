import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/loader_class.dart';
import 'package:postprob/module/your_application/providers/applied_job_provider.dart';
import 'package:postprob/module/your_application/views/your_application_view.dart';
import 'package:postprob/services/api_url.dart';

class MyApplyApplicationListView extends StatefulWidget {
  const MyApplyApplicationListView({super.key});

  @override
  State<MyApplyApplicationListView> createState() => _MyApplyApplicationListViewState();
}

class _MyApplyApplicationListViewState extends State<MyApplyApplicationListView> {
  late AppliedJobProvider appliedJobProvider;

  @override
  void initState() {
    appliedJobProvider = context.read<AppliedJobProvider>();
    appliedJobProvider.getAppliedJobsList(context);
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    "Apply Application",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: blackCl,
                      fontFamily: semiBold,
                      fontSize: 16.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Builder(
                    builder: (context) {
                      if (state.isLoading) {
                        return LoaderClass(height: MediaQuery.of(context).size.height - 200);
                      }
                      if (state.appliedJobsList.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width, height: 250.h),
                            Text(
                              "No Applied Job",
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
                                "You don't have any jobs apply, please find jobs",
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
                      return Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: state.appliedJobsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, createRightToLeftRoute(YourApplicationView(id: state.appliedJobsList[index].id.toString())));
                              },
                              child: Container(
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
                                                padding: const EdgeInsets.all(8),
                                                decoration: const BoxDecoration(color: Color(0xFFD6CDFE), shape: BoxShape.circle),
                                                child:  ClipRRect(
                                                  borderRadius: BorderRadius.circular(20.dm),
                                                  child:   state.appliedJobsList[index].jobDetail!.files != null &&     state.appliedJobsList[index].jobDetail!.files!.isNotEmpty
                                                      ? CachedNetworkImage(
                                                    errorWidget: (context, url, error) => Image.asset(
                                                      videoDemoImg,
                                                      height: 40.h,
                                                      width: 40.w,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    height: 40.h,
                                                    width: 40.w,
                                                    fit: BoxFit.contain,
                                                    imageUrl: ApiUrl.imageUrl +   state.appliedJobsList[index].jobDetail!.files![0].file.toString(),
                                                    placeholder: (a, b) => const Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  )
                                                      : Image.asset(
                                                    itTypeIc,
                                                    height: 40.h,
                                                    width: 40.w,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                state.appliedJobsList[index].jobDetail!.title.toString(),
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
                                                state.appliedJobsList[index].jobDetail!.city!.city.toString(),
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
                                              state.appliedJobsList[index].jobDetail!.position.toString(),
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
                                              state.appliedJobsList[index].jobDetail!.employmentType!.title.toString(),
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
                                              state.appliedJobsList[index].jobDetail!.position.toString(),
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
                                          state.appliedJobsList[index].appliedAt.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: smallTextCl,
                                            fontFamily: regular,
                                            fontSize: 10.sp,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Visibility(
                                          visible: false,
                                          child: RichText(
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
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

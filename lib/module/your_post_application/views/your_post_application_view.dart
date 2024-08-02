import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/loader_class.dart';
import 'package:postprob/module/chat/views/message_view.dart';
import 'package:postprob/module/your_post_application/providers/post_application_provider.dart';

import '../../../services/api_url.dart';

class PostApplicationView extends StatefulWidget {
  final String id;

  const PostApplicationView({super.key, required this.id});

  @override
  State<PostApplicationView> createState() => _PostApplicationViewState();
}

class _PostApplicationViewState extends State<PostApplicationView> {
  late PostApplicationProvider postApplicationProvider;

  @override
  void initState() {
    postApplicationProvider = context.read<PostApplicationProvider>();
    postApplicationProvider.getPostJobDetail(context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostApplicationProvider>(
      builder: (context, state, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: bgCl,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: bgCl,
              automaticallyImplyLeading: false,
              centerTitle: false,
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
              title: Text(
                "Post application",
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
                        SizedBox(width: MediaQuery.of(context).size.width, height: 200.h),
                        Text(
                          "No Post Job Details Found",
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
                            "not get details",
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
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25.h,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
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
                                Row(
                                  children: [
                                    Container(
                                      height: 40.h,
                                      width: 40.w,
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(color: Color(0xFFF5F5F5), shape: BoxShape.circle),
                                      child:  ClipRRect(
                                        borderRadius: BorderRadius.circular(20.dm),
                                        child:  state.myPostDetails.files != null &&   state.myPostDetails.files!.isNotEmpty
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
                                          imageUrl: ApiUrl.imageUrl + state.myPostDetails.files![0].file.toString(),
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
                                    SizedBox(width: 15.w),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.myPostDetails.title.toString(),
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
                                          "${state.myPostDetails.user!.city ?? ""},${state.myPostDetails.user!.state ?? ""}",
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
                                    )
                                  ],
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
                                        state.myPostDetails.description!.toString(),
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
                                SizedBox(height: 10.h),
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
                                        state.myPostDetails.employmentTitle.toString(),
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
                                        state.myPostDetails.city!.city!.toString(),
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Text(
                          "Apply User List",
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
                        SizedBox(
                          height: 25.h,
                          width: MediaQuery.of(context).size.width,
                        ),
                        state.myPostDetails.appliedUsers!.isEmpty
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                child: Center(
                                  child: Text(
                                    "No Apply User",
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
                                ),
                              )
                            : MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.myPostDetails.appliedUsers?.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10.h),
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.dm),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 50.h,
                                            width: 50.w,
                                            padding: const EdgeInsets.all(0),
                                            decoration: const BoxDecoration(color: Color(0xFFD6CDFE), shape: BoxShape.circle),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(25.dm),
                                              child: state.myPostDetails.appliedUsers![index].image != ""
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
                                                      imageUrl: ApiUrl.imageUrl + state.myPostDetails.appliedUsers![index].image.toString(),
                                                      placeholder: (a, b) => const Center(
                                                        child: CircularProgressIndicator(),
                                                      ),
                                                    )
                                                  : Image.asset(demoUser),
                                            ),
                                          ),
                                          SizedBox(width: 15.w),
                                          Expanded(
                                            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                              Text(
                                                state.myPostDetails.appliedUsers![index].name.toString(),
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: mediumTextCl,
                                                  fontFamily: medium,
                                                  fontSize: 14.sp,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              Text(
                                                state.myPostDetails.appliedUsers![index].time.toString(),
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: hintColor,
                                                  fontFamily: regular,
                                                  fontSize: 12.sp,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ]),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context, createRightToLeftRoute( MessageView(id:  state.myPostDetails.appliedUsers![index].id.toString(), user:  state.myPostDetails.appliedUsers![index], userId: state.myPostDetails.user!.id.toString())));
                                                },
                                                child: Image.asset(
                                                  writeIc,
                                                  width: 32.h,
                                                  height: 32.h,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              Text(
                                                "Start Chat",
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: hintColor,
                                                  fontFamily: regular,
                                                  fontSize: 12.sp,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                      ],
                    ),
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

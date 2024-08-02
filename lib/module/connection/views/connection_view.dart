import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/expandable_text.dart';
import 'package:postprob/core/common_widgets/loader_class.dart';
import 'package:postprob/module/connection/providers/connection_provider.dart';
import 'package:postprob/module/connection/views/post_details_view.dart';
import 'package:postprob/services/api_url.dart';

class ConnectionView extends StatefulWidget {
  const ConnectionView({super.key});

  @override
  State<ConnectionView> createState() => _ConnectionViewState();
}

class _ConnectionViewState extends State<ConnectionView> {
  late ConnectionProvider connectionProvider;

  @override
  void initState() {
    connectionProvider = context.read<ConnectionProvider>();
    connectionProvider.getPostList(context, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectionProvider>(
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: bgCl,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width, height: 50.h),
                Builder(
                  builder: (context) {
                    if (state.isLoading) {
                      return LoaderClass(height: MediaQuery.of(context).size.height - 200);
                    }
                    if (state.connectionList.isEmpty) {
                      return Column(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width, height: 100.h),
                          SizedBox(
                            height: 240.h,
                            width: 240.w,
                          ),
                          SizedBox(height: 42.h),
                          Text(
                            "No Post",
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
                              "currently have no post",
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
                    return Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.connectionList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, createRightToLeftRoute(PostDetailsView(postId: state.connectionList[index].id.toString())));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 15.h),
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
                                              child: state.connectionList[index].files != null && state.connectionList[index].files!.isNotEmpty
                                                  ? CachedNetworkImage(
                                                      errorWidget: (context, url, error) => Image.asset(
                                                        videoDemoImg,
                                                        height: 50.h,
                                                        width: 50.w,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      height: 50.h,
                                                      width: 50.w,
                                                      fit: BoxFit.contain,
                                                      imageUrl: ApiUrl.imageUrl + state.connectionList[index].files![0].file.toString(),
                                                      placeholder: (a, b) => const Center(
                                                        child: CircularProgressIndicator(),
                                                      ),
                                                    )
                                                  : Image.asset(
                                                      itTypeIc,
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
                                                    state.connectionList[index].user != null ? state.connectionList[index].user!.name.toString() : "",
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
                                                        state.connectionList[index].postedAt.toString(),
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
                                            ),
                                            SizedBox(width: 11.w),
                                            GestureDetector(
                                              onTap: () {
                                                if (state.connectionList[index].isSaved == 0) {
                                                  state.savePost(context, state.connectionList[index].id.toString());
                                                } else {
                                                  state.removeSavedPost(context, state.connectionList[index].id.toString());
                                                }
                                              },
                                              child: Container(
                                                height: 40.h,
                                                width: 40.w,
                                                padding: EdgeInsets.all(state.connectionList[index].isSaved == 0 ? 7.h : 10.h),
                                                child: Image.asset(
                                                  state.connectionList[index].isSaved == 0 ? saveIc : bookmarkFillIc,
                                                  height: 24.h,
                                                  width: 24.w,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.h),
                                        Text(
                                          state.connectionList[index].title.toString(),
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
                                          state.connectionList[index].description.toString(),
                                          trimLines: 4,
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
                                          state.connectionList[index].shareCount.toString(),
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
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

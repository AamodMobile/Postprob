import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/loader_class.dart';
import 'package:postprob/module/your_post_application/providers/post_application_provider.dart';
import 'package:postprob/module/your_post_application/views/your_post_application_view.dart';
import 'package:postprob/services/api_url.dart';

class PostApplicationListView extends StatefulWidget {
  const PostApplicationListView({super.key});

  @override
  State<PostApplicationListView> createState() => _PostApplicationListViewState();
}

class _PostApplicationListViewState extends State<PostApplicationListView> {
  late PostApplicationProvider postApplicationProvider;

  @override
  void initState() {
    postApplicationProvider = context.read<PostApplicationProvider>();
    postApplicationProvider.getPostJobsList(context);
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
                    "Post Application",
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
                      if (state.postJobsList.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width, height: 250.h),
                            Text(
                              "No Post Job",
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
                                "You don't have any jobs post, please post jobs",
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
                          itemCount: state.postJobsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    createRightToLeftRoute(PostApplicationView(
                                      postJobsListModel: state.postJobsList[index],
                                    )));
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
                                                child: state.postJobsList[index].user!.image != ""
                                                    ? ClipRRect(
                                                        borderRadius: BorderRadius.circular(20.dm),
                                                        child: CachedNetworkImage(
                                                          errorWidget: (context, url, error) => Image.asset(
                                                            appleIc,
                                                            height: 40.h,
                                                            width: 40.w,
                                                         fit: BoxFit.cover,
                                                          ),
                                                          height: 40.h,
                                                          width: 40.w,
                                                       fit: BoxFit.cover,
                                                          imageUrl: ApiUrl.imageUrl + state.postJobsList[index].user!.image.toString(),
                                                          placeholder: (a, b) => const Center(
                                                            child: CircularProgressIndicator(),
                                                          ),
                                                        ),
                                                      )
                                                    : Image.asset(appleIc),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                state.postJobsList[index].category!.title.toString(),
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
                                                state.postJobsList[index].city!.city.toString(),
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
                                              state.postJobsList[index].position!.toString(),
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
                                              state.postJobsList[index].employmentType!.title.toString(),
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
                                              state.postJobsList[index].position!.toString(),
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
                                          formatCreatedAt(state.postJobsList[index].createdAt),
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
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String formatCreatedAt(DateTime? createdAt) {
    if (createdAt == null) return '';
    DateTime now = DateTime.now();
    Duration difference = now.difference(createdAt);
    if (difference.inDays == 0) {
      if (difference.inHours >= 1) {
        return '${difference.inHours} ${difference.inHours == 1 ? 'hour ago' : 'hours ago'}';
      } else {
        return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute ago' : 'minutes ago'}';
      }
    } else if (difference.inDays <= 7) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day ago' : 'days ago'}';
    } else if (difference.inDays <= 30) {
      int weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week ago' : 'weeks ago'}';
    } else if (difference.inDays <= 365) {
      int months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month ago' : 'months ago'}';
    } else {
      int years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year ago' : 'years ago'}';
    }
  }
}

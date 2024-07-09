import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/loader_class.dart';
import 'package:postprob/module/connection/models/post_list_model.dart';
import 'package:postprob/module/dashboard/providers/dashboard_provider.dart';
import 'package:postprob/module/home/providers/home_provider.dart';
import 'package:postprob/module/job_view/view/job_details_view.dart';
import 'package:postprob/module/profile/views/profile_details_view.dart';
import 'package:postprob/services/api_url.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeProvider homeProvider;

  @override
  void initState() {
    homeProvider = context.read<HomeProvider>();
    homeProvider.userGetProfile(context);
    homeProvider.getHomeDataApi(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Stack(
              children: [
                state.isLoading ? LoaderClass(height: MediaQuery.of(context).size.height - 200) : const SizedBox(),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.022),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 18.h,
                                ),
                                Text(
                                  "Hello",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: blackCl,
                                    fontFamily: bold,
                                    fontSize: 22.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  state.profileModel.name ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: blackCl,
                                    fontFamily: bold,
                                    fontSize: 22.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 30.w),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, createBottomToTopRoute(const ProfileDetailsView(title: ''), 1));
                            },
                            child: Container(
                              height: 40.h,
                              width: 40.w,
                              decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: mainColor,width: 1.w)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.dm),
                                child: state.profileModel.image != ""
                                    ? CachedNetworkImage(
                                        errorWidget: (context, url, error) => Image.asset(
                                          demoUser,
                                          height: 40.h,
                                          width: 40.w,
                                          fit: BoxFit.cover,
                                        ),
                                        height: 40.h,
                                        width: 40.w,
                                        fit: BoxFit.cover,
                                        imageUrl: ApiUrl.imageUrl + state.profileModel.image.toString(),
                                        placeholder: (a, b) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : Image.asset(
                                        demoUser,
                                        height: 40.h,
                                        width: 40.w,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            clipBehavior: Clip.none,
                            height: MediaQuery.of(context).size.height * 0.18,
                            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                              Container(
                                clipBehavior: Clip.none,
                                padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 20.h),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.17,
                                decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(6)),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "50% More ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: medium,
                                              fontSize: 14.sp,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "Business with Premium",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: medium,
                                              fontSize: 14.sp,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 12.h),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 4.h),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFF9228),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              "Join Now",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: medium,
                                                fontSize: 12.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Image.asset(
                              officeGirlImg,
                              height: 180,
                              width: 180,
                              fit: BoxFit.contain,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                      Text(
                        "Find Your to solve",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: blackCl,
                          fontFamily: semiBold,
                          fontSize: 16.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                //Navigator.push(context, createRightToLeftRoute(const SpecializationView()));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 37.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xFFAFECFE),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      headHuntingIc,
                                      height: 36.h,
                                      width: 36.w,
                                    ),
                                    SizedBox(height: 16.h),
                                    Text(
                                      state.postCounts,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: blackCl,
                                        fontFamily: semiBold,
                                        fontSize: 16.sp,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      "Problem posted",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: blackCl,
                                        fontFamily: medium,
                                        fontSize: 14.sp,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: MediaQuery.of(context).size.height * 0.015),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0xFFBEAFFE),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        state.fullTimePosts,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: blackCl,
                                          fontFamily: semiBold,
                                          fontSize: 16.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "Full Time",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: blackCl,
                                          fontFamily: medium,
                                          fontSize: 14.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.022),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: MediaQuery.of(context).size.height * 0.015),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0xFFFFD6AD),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        state.partTimePosts,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: blackCl,
                                          fontFamily: semiBold,
                                          fontSize: 16.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "Part Time",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: blackCl,
                                          fontFamily: medium,
                                          fontSize: 14.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      Text(
                        "Recent Problem Posted",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: blackCl,
                          fontFamily: semiBold,
                          fontSize: 16.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: state.posts.length + 1,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            if (index == state.posts.length) {
                              return Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    Provider.of<DashboardProvider>(context, listen: false).navigateToFirstIndex(1);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 10.h),
                                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20.dm),
                                      border: Border.all(
                                        color: const Color(0xFF0D0140),
                                      ),
                                    ),
                                    child: Text(
                                      "SHOW More",
                                      style: TextStyle(
                                        color: const Color(0xFF0D0140),
                                        fontFamily: regular,
                                        fontSize: 12.sp,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              PostListModel postJob = state.posts[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, createRightToLeftRoute(JobDetailsView(postId: postJob.id.toString())));
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
                                          Container(
                                            height: 40.h,
                                            width: 40.w,
                                            padding: EdgeInsets.all(5.w),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFD6CDFE),
                                              shape: BoxShape.circle,
                                            ),
                                            child: postJob.user!.image != ""
                                                ? ClipRRect(
                                                    borderRadius: BorderRadius.circular(20.dm),
                                                    child: CachedNetworkImage(
                                                      errorWidget: (context, url, error) => Image.asset(
                                                        demoUser,
                                                        height: 50.h,
                                                        width: 50.w,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      height: 50.h,
                                                      width: 50.w,
                                                      fit: BoxFit.cover,
                                                      imageUrl: ApiUrl.imageUrl + postJob.user!.image.toString(),
                                                      placeholder: (a, b) => const Center(
                                                        child: CircularProgressIndicator(),
                                                      ),
                                                    ),
                                                  )
                                                : Image.asset(appleIc),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  postJob.title.toString(),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // Replace with your color
                                                    fontFamily: medium,
                                                    fontSize: 14.sp,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Text(
                                                  postJob.city!.city.toString(),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    // Replace with your color
                                                    fontFamily: regular,
                                                    fontSize: 12.sp,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (postJob.isSaved == 0) {
                                                state.savePost(context, postJob.id.toString());
                                              } else {
                                                state.removeSavedPost(context, postJob.id.toString());
                                              }
                                            },
                                            child: Container(
                                              height: 40.h,
                                              width: 40.w,
                                              padding: EdgeInsets.all(postJob.isSaved == 0 ? 7.h : 10.h),
                                              child: Image.asset(
                                                postJob.isSaved == 0 ? saveIc : bookmarkFillIc,
                                                height: 24.h,
                                                width: 24.w,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.015,
                                      ),
                                      Visibility(
                                        visible: false,
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            text: "\$15K",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: medium,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              color: Colors.black, // Replace with your color
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '/Mon',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily: regular,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.grey,
                                                  // Replace with your color
                                                  decoration: TextDecoration.underline,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.009,
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
                                                postJob.position.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  // Replace with your color
                                                  fontFamily: regular,
                                                  fontSize: 10.sp,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 5.h),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: const Color(0xFFf5f4f6),
                                              ),
                                              child: Text(
                                                postJob.employmentType!.title.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  // Replace with your color
                                                  fontFamily: regular,
                                                  fontSize: 10.sp,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 28.w,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 5.h),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: const Color(0xFFf5f4f6),
                                              ),
                                              child: Text(
                                                "Apply",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  // Replace with your color
                                                  fontFamily: regular,
                                                  fontSize: 10.sp,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.dm),
                            child: Image.asset(
                              googleAds,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

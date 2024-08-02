// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/module/add_project/providers/add__post_provider.dart';
import 'package:postprob/module/dashboard/view/dashboard_view.dart';
import 'package:postprob/module/your_post_application/views/your_post_application_view.dart';
import 'package:postprob/services/api_url.dart';

class SharedJobView extends StatefulWidget {
  const SharedJobView({super.key});

  @override
  State<SharedJobView> createState() => _SharedJobViewState();
}

class _SharedJobViewState extends State<SharedJobView> {
  late AddPostProvider addPostProvider;

  @override
  void initState() {
    super.initState();
    addPostProvider = context.read<AddPostProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPostProvider>(
      builder: (context, addPostState, child) {
        return WillPopScope(
          onWillPop: () async {
            bool willLeave = false;
            Navigator.pushReplacement(context, createLeftToRightRoute(const DashboardView(index: 0)));
            return willLeave;
          },
          child: SafeArea(
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
                    Navigator.pushReplacement(context, createLeftToRightRoute(const DashboardView(index: 0)));
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, createLeftToRightRoute(const DashboardView(index: 2)));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        "Post",
                        style: TextStyle(
                          color: yellowDark,
                          fontFamily: medium,
                          fontSize: 14.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      Text(
                        "Shared a Problem",
                        style: TextStyle(
                          color: mediumTextCl,
                          fontFamily: medium,
                          fontSize: 14.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.dm),
                            child: addPostState.successPostModel.user!.image != ""
                                ? CachedNetworkImage(
                                    errorWidget: (context, url, error) => Image.asset(
                                      demoUser,
                                      height: 56.h,
                                      width: 56.w,
                                      fit: BoxFit.cover,
                                    ),
                                    height: 56.h,
                                    width: 56.w,
                                    fit: BoxFit.cover,
                                    imageUrl: ApiUrl.imageUrl + addPostState.successPostModel.user!.image.toString(),
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Image.asset(
                                    demoUser,
                                    height: 56.h,
                                    width: 56.w,
                                  ),
                          ),
                          SizedBox(width: 11.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  addPostState.successPostModel.user!.name.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: mediumTextCl,
                                    fontFamily: medium,
                                    fontSize: 14.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "${addPostState.successPostModel.user!.city.toString()},${addPostState.successPostModel.user!.state.toString()}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: smallTextCl,
                                    fontFamily: regular,
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 32.h),
                      Text(
                        "Description",
                        style: TextStyle(
                          color: mediumTextCl,
                          fontFamily: medium,
                          fontSize: 12.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.all(20.h),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.dm)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              addPostState.successPostModel.description!.toString(),
                              style: TextStyle(
                                color: smallTextCl,
                                fontFamily: regular,
                                fontSize: 12.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F8F9),
                                borderRadius: BorderRadius.circular(15.dm),
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
                                        padding: const EdgeInsets.all(7),
                                        decoration: const BoxDecoration(color: Color(0xFFC4C4C4), shape: BoxShape.circle),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20.dm),
                                          child: addPostState.successPostModel.files != null && addPostState.successPostModel.files!.isNotEmpty
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
                                                  imageUrl: ApiUrl.imageUrl + addPostState.successPostModel.files![0].file.toString(),
                                                  placeholder: (a, b) => const Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                )
                                              : Image.asset(itTypeIc),
                                        ),
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              addPostState.successPostModel.category!.title!.toString(),
                                              style: TextStyle(
                                                color: mediumTextCl,
                                                fontFamily: medium,
                                                fontSize: 12.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              addPostState.successPostModel.title!.toString(),
                                              style: TextStyle(
                                                color: smallTextCl,
                                                fontFamily: regular,
                                                fontSize: 12.sp,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              "${addPostState.successPostModel.user!.city.toString()},${addPostState.successPostModel.user!.state.toString()}",
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
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, createLeftToRightRoute(PostApplicationView(id: addPostState.successPostModel.id.toString())));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(20.dm),
                                          border: Border.all(
                                            color: const Color(0xFF0D0140),
                                          ),
                                        ),
                                        child: Text(
                                          "Application details",
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
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              bottomSheet: Container(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                decoration: const BoxDecoration(color: bgCl),
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 20.h),
                        CustomButtonWidget(
                          onPressed: () {
                            Navigator.pushReplacement(context, createLeftToRightRoute(const DashboardView(index: 0)));
                          },
                          text: "BACK TO HOME",
                        ),
                        SizedBox(height: 10.h)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

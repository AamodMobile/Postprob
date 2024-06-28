import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/expandable_text.dart';
import 'package:postprob/core/common_widgets/route_animation.dart';
import 'package:postprob/module/connection/views/post_details_view.dart';

class ConnectionView extends StatefulWidget {
  const ConnectionView({super.key});

  @override
  State<ConnectionView> createState() => _ConnectionViewState();
}

class _ConnectionViewState extends State<ConnectionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgCl,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width, height: 50.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, createRightToLeftRoute(const PostDetailsView()));
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
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        demoUser,
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
                                            "Arnold Leonardo",
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
                                                "21 minutes ago",
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
                                    Image.asset(
                                      saveIc,
                                      height: 24.h,
                                      width: 24.w,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "What are the characteristics of a fake job call form?",
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
                                const ExpandableText(
                                  demoString,
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
                                  "2",
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
            ),
          ],
        ),
      ),
    );
  }
}

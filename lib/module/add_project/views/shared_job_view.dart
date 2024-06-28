import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';

class SharedJobView extends StatefulWidget {
  const SharedJobView({super.key});

  @override
  State<SharedJobView> createState() => _SharedJobViewState();
}

class _SharedJobViewState extends State<SharedJobView> {
  @override
  Widget build(BuildContext context) {
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
            GestureDetector(
              onTap: () {},
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
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
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
                            "Arnold Leonardo",
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
                            "California, USA",
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
                    children: [
                      Text(
                        "Hey guys\n\nI need a game fitness trainer for my children. Our game fitness trainer is designed to help you achieve your fitness goals while having fun! With interactive challenges and engaging workouts, you'll stay motivated and eager to level up.",
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
                                  child: Image.asset(appleIc),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Fitness Trainer",
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
                                        "Job vacancies from Apple company",
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
                                        "California, USA , On-site",
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
      ),
    );
  }
}

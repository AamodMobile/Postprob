import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';

class ProblemLocationSheet {
  final List<String> location = [
    "Califon, United States",
    "California, United States",
    "California City, United States",
  ];
  String selectedValue = "";

  Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.dm),
              ),
              child: Wrap(
                children: [
                  Column(

                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        width: 30.w,
                        height: 3.h,
                        decoration: BoxDecoration(color: const Color(0xFF5B5858), borderRadius: BorderRadius.circular(3.dm)),
                      ),
                      SizedBox(height: 50.h),
                      Text(
                        "Saved addresses",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: mediumTextCl,
                          fontFamily: medium,
                          fontSize: 16.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 11.h),
                      Text(
                        "Determine and choose the type of work according to what you want",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: smallTextCl,
                          fontFamily: regular,
                          fontSize: 14.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      MediaQuery.removePadding(
                        removeTop: true,
                        removeBottom: true,
                        removeLeft: true,
                        removeRight: true,
                        context: context,
                        child: ListView.builder(
                          itemCount: location.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedValue = location[index];
                                });
                                Navigator.pop(context, location[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 25.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      location[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: smallTextCl,
                                        fontFamily: regular,
                                        fontSize: 14.sp,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Image.asset(
                                      selectedValue == location[index] ? circleSelectIc : circleDefultIc,
                                      height: 18.h,
                                      width: 18.w,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

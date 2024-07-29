import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/add_project/models/cities_model.dart';
import 'package:postprob/module/add_project/providers/add__post_provider.dart';

class ProblemLocationSheet {
  Future<CitiesModel?> show(BuildContext context, AddPostProvider postProvider) async {
    return await showModalBottomSheet<CitiesModel>(
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
                      SizedBox(
                       height: 300.h,
                        child: ListView.builder(
                          itemCount: postProvider.cityList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                postProvider.locationUpdate(postProvider.cityList[index].id.toString(), postProvider.cityList[index].title.toString());
                                Navigator.pop(context, postProvider.cityList[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 25.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        postProvider.cityList[index].title.toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: smallTextCl,
                                          fontFamily: regular,
                                          fontSize: 14.sp,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      postProvider.locationId == postProvider.cityList[index].id.toString() ? circleSelectIc : circleDefultIc,
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
                      SizedBox(height: 20.h),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';

class LevelPupUp extends StatefulWidget {
  const LevelPupUp({super.key});

  @override
  State<LevelPupUp> createState() => _LevelPupUpState();
}

class _LevelPupUpState extends State<LevelPupUp> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                width: 30.w,
                height: 3.h,
                decoration: BoxDecoration(color: Color(0xFF5B5858), borderRadius: BorderRadius.circular(3.dm)),
              ),
              SizedBox(height: 40.h),
              MediaQuery.removePadding(
                removeTop: true,
                removeBottom: true,
                removeLeft: true,
                removeRight: true,
                context: context,
                child: ListView.builder(
                  itemCount: 11,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 25.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Level $index",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: smallTextCl,
                              fontFamily: regular,
                              fontSize: 14.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState((){
                                selectedIndex=index;
                              });
                            },
                            child: Image.asset(
                              selectedIndex == index ? circleSelectIc : circleDefultIc,
                              height: 18.h,
                              width: 18.w,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 25.h),
              CustomButtonWidget(
                onPressed: () {},
                text: "Done".toUpperCase(),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_check_box.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';

class AddWorkExperienceView extends StatefulWidget {
  const AddWorkExperienceView({super.key});

  @override
  State<AddWorkExperienceView> createState() => _AddWorkExperienceViewState();
}

class _AddWorkExperienceViewState extends State<AddWorkExperienceView> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgCl,
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
                  height: 26.h,
                  width: 26.w,
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  "Add work experience",
                  style: TextStyle(
                    color: mediumTextCl,
                    fontFamily: medium,
                    fontSize: 14.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 30.h),
                CustomTextField(
                  hintText: "Job tittle",
                  labelText: "Job title",
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: "Company Name",
                  labelText: "Company",
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: "",
                        labelText: "Start date",
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: CustomTextField(
                        hintText: "",
                        labelText: "End date",
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    LabeledCheckbox(
                      label: '',
                      value: isCheck,
                      color: Colors.white,
                      onChanged: (v) {
                        setState(() {
                          isCheck = v;
                        });
                      },
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      "This is my position now",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: hintColor,
                        fontFamily: regular,
                        fontSize: 12.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: "Write additional information here",
                  labelText: "Description",
                  maxCheck: 5,
                ),
                SizedBox(height: 100.h),
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
                  CustomButtonWidget(
                    onPressed: () {},
                    text: "SAVE".toUpperCase(),
                  ),
                  SizedBox(height: 20.h)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

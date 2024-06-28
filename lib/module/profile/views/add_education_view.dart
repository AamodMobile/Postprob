import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_check_box.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/profile/views/level_of_education_view.dart';

class AddEducationView extends StatefulWidget {
  const AddEducationView({super.key});

  @override
  State<AddEducationView> createState() => _AddEducationViewState();
}

class _AddEducationViewState extends State<AddEducationView> {
  bool isCheck = false;
  TextEditingController levelEd = TextEditingController();

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
                SizedBox(height: 30.h),
                Text(
                  "Add Education",
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
                  hintText: "",
                  onTap: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LevelOfEducation()),
                    );
                    if (result != null) {
                      setState(() {
                        levelEd.text = result.title;
                      });
                    }
                  },
                  readOnly: true,
                  controller: levelEd,
                  labelText: "Level of education",
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: "",
                  labelText: "Institution name",
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: "",
                  labelText: "Field of study",
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
                SizedBox(height: 120.h)
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

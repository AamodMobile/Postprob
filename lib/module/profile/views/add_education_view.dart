import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_check_box.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/profile/models/profile_model.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';
import 'package:postprob/module/profile/views/level_of_education_view.dart';

class AddEducationView extends StatefulWidget {
  final bool isEdit;
  final String id;
  final Education? education;

  const AddEducationView({super.key, required this.isEdit, required this.id, this.education});

  @override
  State<AddEducationView> createState() => _AddEducationViewState();
}

class _AddEducationViewState extends State<AddEducationView> {
  TextEditingController levelEd = TextEditingController();
  bool isCheck = false;
  late final ProfileProvider profileProvider;
  final formKey = GlobalKey<FormState>();
  String id = "";

  @override
  void initState() {
    profileProvider = context.read<ProfileProvider>();
    profileProvider.reset();
    if (widget.isEdit) {
      levelEd.text = widget.education!.educationLavel.toString();
      profileProvider.institutionName.text = widget.education!.institutionName.toString();
      profileProvider.startDateStudy.text = widget.education!.startDate.toString();
      profileProvider.endDateStudy.text = widget.education!.endDate.toString();
      profileProvider.fieldOfStudy.text = widget.education!.fieldOfStudy.toString();
      profileProvider.educationDescription.text = widget.education!.description.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, state, child) {
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
              child: Form(
                key: formKey,
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
                            id = result.id.toString();
                          });
                        }
                      },
                      readOnly: true,
                      controller: levelEd,
                      labelText: "Level of education",
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Enter Level of education";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      hintText: "",
                      labelText: "Institution name",
                      controller: state.institutionName,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Enter Institution name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      hintText: "",
                      labelText: "Field of study",
                      controller: state.fieldOfStudy,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Enter Field of study";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            hintText: "",
                            onTap: () {
                              state.openDatePicker(context, true, "Education");
                            },
                            labelText: "Start date",
                            readOnly: true,
                            controller: state.startDateStudy,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Enter Start date";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          child: CustomTextField(
                            hintText: "",
                            labelText: "End date",
                            readOnly: true,
                            onTap: () {
                              if (isCheck) {
                              } else {
                                state.openDatePicker(context, false, "Education");
                              }
                            },
                            controller: state.endDateStudy,
                            validator: (v) {
                              if (isCheck) {
                                return null;
                              } else {
                                if (v!.isEmpty) {
                                  return "Enter End date";
                                }
                                return null;
                              }
                            },
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
                              state.endDateStudy.text = "";
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
                      controller: state.educationDescription,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Enter Description";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 350.h)
                  ],
                ),
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
                      onPressed: () {
                        if (widget.isEdit) {
                          state.addUserEducationApi(
                            context,
                            widget.id,
                            id,
                            state.institutionName.text,
                            state.fieldOfStudy.text,
                            state.startDateStudy.text,
                            state.endDateStudy.text,
                            state.educationDescription.text,
                            isCheck ? "1" : "0",
                          );
                        } else {
                          if (formKey.currentState!.validate()) {
                            state.addUserEducationApi(
                              context,
                              widget.id,
                              id,
                              state.institutionName.text,
                              state.fieldOfStudy.text,
                              state.startDateStudy.text,
                              state.endDateStudy.text,
                              state.educationDescription.text,
                              isCheck ? "1" : "0",
                            );
                          }
                        }
                      },
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
    });
  }
}

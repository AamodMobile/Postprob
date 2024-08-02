import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_check_box.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/profile/models/profile_model.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';

class AddWorkExperienceView extends StatefulWidget {
  final bool isEdit;
  final String id;
  final Experience? experience;

  const AddWorkExperienceView({super.key, required this.isEdit, required this.id, this.experience});

  @override
  State<AddWorkExperienceView> createState() => _AddWorkExperienceViewState();
}

class _AddWorkExperienceViewState extends State<AddWorkExperienceView> {
  bool isCheck = false;
  late final ProfileProvider profileProvider;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    profileProvider = context.read<ProfileProvider>();
    profileProvider.reset();
    if (widget.isEdit) {
      profileProvider.jobTittle.text = widget.experience!.title.toString();
      profileProvider.companyName.text = widget.experience!.company.toString();
      profileProvider.startDate.text = widget.experience!.startDate.toString();
      profileProvider.endDate.text = widget.experience!.endDate.toString();
      profileProvider.jobDescription.text = widget.experience!.description.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, state, child) {
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
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      "${widget.isEdit ? "Update" : "Add"} work experience",
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
                      controller: state.jobTittle,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Enter Job Tittle";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      hintText: "Company Name",
                      labelText: "Company",
                      controller: state.companyName,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Enter Company Name";
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
                            readOnly: true,
                            onTap: () {
                              state.openDatePicker(context, true, "work experience");
                            },
                            labelText: "Start date",
                            controller: state.startDate,
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
                            readOnly: true,
                            onTap: () {
                              if (isCheck) {
                              } else {
                                state.openDatePicker(context, false, "work experience");
                              }
                            },
                            labelText: "End date",
                            controller: state.endDate,
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
                              state.endDate.text = "";
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
                      controller: state.jobDescription,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Enter Description";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 100.h),
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
                          if (formKey.currentState!.validate()) {
                            state.addUserExperienceApi(
                              context,
                              widget.id,
                              state.jobTittle.text,
                              state.companyName.text,
                              state.startDate.text,
                              state.endDate.text,
                              state.jobDescription.text,
                              isCheck ? "1" : "0",
                            );
                          }
                        } else {
                          if (formKey.currentState!.validate()) {
                            state.addUserExperienceApi(
                              context,
                              widget.id,
                              state.jobTittle.text,
                              state.companyName.text,
                              state.startDate.text,
                              state.endDate.text,
                              state.jobDescription.text,
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

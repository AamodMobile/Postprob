import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/settings/providers/setting_provider.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({super.key});

  @override
  State<UpdatePasswordView> createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  late SettingProvider settingProvider;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    settingProvider = context.read<SettingProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, state, child) {
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
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Text(
                    "Update Password",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: blackCl,
                      fontFamily: semiBold,
                      fontSize: 16.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 26.h),
                  CustomTextField(
                    labelText: "Old Password",
                    hintText: "Old Password",
                    fillColor: Colors.white,
                    controller: state.oldPassword,
                    obscureText: state.isHide,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Enter Old Password";
                      }
                      return null;
                    },
                    leading1: GestureDetector(
                      onTap: () {
                        if (state.isHide) {
                          state.isShow(false);
                        } else {
                          state.isShow(true);
                        }
                      },
                      child: Image.asset(
                        state.isHide ? phEyeIc : iconEyeHideIc,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  CustomTextField(
                    labelText: "New Password",
                    hintText: "New Password",
                    fillColor: Colors.white,
                    controller: state.newPassWord,
                    obscureText: state.isHide,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Enter New Password";
                      }
                      return null;
                    },
                    leading1: GestureDetector(
                      onTap: () {
                        if (state.isHide) {
                          state.isShow(false);
                        } else {
                          state.isShow(true);
                        }
                      },
                      child: Image.asset(
                        state.isHide ? phEyeIc : iconEyeHideIc,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  CustomTextField(
                    labelText: "Confirm Password",
                    hintText: "Confirm Password",
                    fillColor: Colors.white,
                    controller: state.confirmPassword,
                    obscureText: state.isHide,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Enter Confirm Password";
                      } else if (state.newPassWord.text != state.confirmPassword.text) {
                        return "Password mismatch";
                      }
                      return null;
                    },
                    leading1: GestureDetector(
                      onTap: () {
                        if (state.isHide) {
                          state.isShow(false);
                        } else {
                          state.isShow(true);
                        }
                      },
                      child: Image.asset(
                        state.isHide ? phEyeIc : iconEyeHideIc,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            decoration: const BoxDecoration(color: bgCl),
            child: Wrap(
              children: [
                Column(
                  children: [
                    CustomButtonWidget(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          state.changePassword(context, state.oldPassword.text, state.newPassWord.text, state.confirmPassword.text);
                        }
                      },
                      text: "Update".toUpperCase(),
                    ),
                    SizedBox(height: 90.h)
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

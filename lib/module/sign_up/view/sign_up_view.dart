import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_check_box.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/sign_up/providers/sign_up_provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool? isCheck = false;
  late final SignUpProvider signUpProvider;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    signUpProvider = context.read<SignUpProvider>();
    signUpProvider.getCheckInStatus(context);
    signUpProvider.getCities(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, state, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white.withOpacity(0.97),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.04),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      Text(
                        "Create an Account",
                        style: TextStyle(
                          color: blackCl,
                          fontFamily: semiBold,
                          fontSize: 30.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.01),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: blackCl,
                            fontFamily: regular,
                            fontSize: 12.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      CustomTextField(
                        labelText: "Full name",
                        fillColor: Colors.white,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Enter name";
                          }
                          return null;
                        },
                        onChanged: (v) {
                          state.nameUpdate(v);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      CustomTextField(
                        labelText: "Email",
                        fillColor: Colors.white,
                        controller: state.emailController,
                        validator: state.emailValidator,
                        txKeyboardType: TextInputType.emailAddress,
                        onChanged: (v) {
                          state.emailUpdate(v);
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      CustomTextField(
                        labelText: "Password",
                        fillColor: Colors.white,
                        obscureText: state.isHide,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Enter password";
                          }
                          return null;
                        },
                        onChanged: (v) {
                          state.passwordUpdate(v);
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      /* const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "City",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0D0140),
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<CitiesModel?>(
                          buttonStyleData: ButtonStyleData(
                            height: 45,
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white,
                              ),
                              color: Colors.white,
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: ImageIcon(
                              AssetImage(arrowDropDown),
                              size: 12,
                            ),
                            iconSize: 14,
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            maxHeight: 200,
                            width: MediaQuery.of(context).size.width * 0.84,
                            useSafeArea: true,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                            ),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all(6),
                              thumbVisibility: MaterialStateProperty.all(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 45,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                          isDense: true,
                          value: state.cityModel,
                          hint: const Text(
                            "Select City",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontFamily: regular,
                              fontSize: 12,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.bold),
                          isExpanded: true,
                          items: state.cityList
                              .map((s) => DropdownMenuItem<CitiesModel>(
                                    value: s,
                                    child: Text(
                                      " ${s.title}",
                                      style: const TextStyle(
                                        fontFamily: regular,
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (CitiesModel? value) {
                            if (value != null) {
                              state.cityUpdate(value, value.id.toString());
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),*/ /* const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "City",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0D0140),
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<CitiesModel?>(
                          buttonStyleData: ButtonStyleData(
                            height: 45,
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white,
                              ),
                              color: Colors.white,
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: ImageIcon(
                              AssetImage(arrowDropDown),
                              size: 12,
                            ),
                            iconSize: 14,
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            maxHeight: 200,
                            width: MediaQuery.of(context).size.width * 0.84,
                            useSafeArea: true,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                            ),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all(6),
                              thumbVisibility: MaterialStateProperty.all(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 45,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                          isDense: true,
                          value: state.cityModel,
                          hint: const Text(
                            "Select City",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontFamily: regular,
                              fontSize: 12,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.bold),
                          isExpanded: true,
                          items: state.cityList
                              .map((s) => DropdownMenuItem<CitiesModel>(
                                    value: s,
                                    child: Text(
                                      " ${s.title}",
                                      style: const TextStyle(
                                        fontFamily: regular,
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (CitiesModel? value) {
                            if (value != null) {
                              state.cityUpdate(value, value.id.toString());
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              LabeledCheckbox(
                                label: '',
                                value: isCheck!,
                                onChanged: (v) {
                                  setState(() {
                                    isCheck = v;
                                  });
                                },
                              ),
                              SizedBox(width: 15.w),
                              Text(
                                "Remember me",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: hintColor,
                                  fontFamily: medium,
                                  fontSize: 12.sp,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Forgot Password ?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: blackCl,
                              fontFamily: semiBold,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.040,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                        child: CustomButtonWidget(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (state.city != "") {
                                state.registerApiCall(context, state.state, state.city);
                              } else {
                                state.getCheckInStatus(context);
                              }
                            }
                          },
                          text: "Sign up",
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.030,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03),
                        child: CustomButtonWidget(
                          onPressed: () {
                            if (state.city != "") {
                              state.signInWithGoogle(context, state.city, state.state);
                            } else {
                              state.getCheckInStatus(context);
                            }
                          },
                          text: "Sign up with Google",
                          style: CustomButtonStyle.style2,
                          iconWidget: Image.asset(
                            googleIc,
                            height: 20.h,
                            width: 16.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.030,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: medium,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: smallTextCl,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                text: "You have already an account? ",
                              ),
                              TextSpan(
                                text: 'Sign in',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: medium,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  color: yellowDark,
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

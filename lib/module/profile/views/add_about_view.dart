import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';

class AddAboutView extends StatefulWidget {
  final String about;

  const AddAboutView({super.key, required this.about});

  @override
  State<AddAboutView> createState() => _AddAboutViewState();
}

class _AddAboutViewState extends State<AddAboutView> {
  late ProfileProvider profileProvider;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    profileProvider = context.read<ProfileProvider>();
    profileProvider.reset();
    profileProvider.about.text = widget.about;
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
                    height: 26,
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
                      "About me",
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
                      hintText: "Tell me about you.",
                      maxCheck: 7,
                      controller: state.about,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Tell me about you";
                        }
                        return null;
                      },
                    )
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
                        if (formKey.currentState!.validate()) {
                          state.addAbout(context, state.about.text);
                        }
                      },
                      text: "SAVE".toUpperCase(),
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

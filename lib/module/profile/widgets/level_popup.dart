import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';

class LevelPupUp extends StatefulWidget {
  final ProfileProvider profileProvider;
  final bool isOral;

  const LevelPupUp({super.key, required this.profileProvider, required this.isOral});

  @override
  State<LevelPupUp> createState() => _LevelPupUpState();
}

class _LevelPupUpState extends State<LevelPupUp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, state, child) {
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
                  decoration: BoxDecoration(color: const Color(0xFF5B5858), borderRadius: BorderRadius.circular(3.dm)),
                ),
                SizedBox(height: 40.h),
                MediaQuery.removePadding(
                  removeTop: true,
                  removeBottom: true,
                  removeLeft: true,
                  removeRight: true,
                  context: context,
                  child: ListView.builder(
                    itemCount: widget.profileProvider.languageLevelList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 25.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.profileProvider.languageLevelList[index].title.toString(),
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
                              onTap: () {
                                if (widget.isOral) {
                                  widget.profileProvider.setSelectedOralLevelLanguage(widget.profileProvider.languageLevelList[index]);
                                } else {
                                  widget.profileProvider.setSelectedWrittenLevelLanguage(widget.profileProvider.languageLevelList[index]);
                                }
                              },
                              child: Image.asset(
                                widget.isOral
                                    ? (widget.profileProvider.selectedOralLevelLanguage == widget.profileProvider.languageLevelList[index])
                                        ? circleSelectIc
                                        : circleDefultIc
                                    : (widget.profileProvider.selectedWrittenLevelLanguage == widget.profileProvider.languageLevelList[index])
                                        ? circleSelectIc
                                        : circleDefultIc,
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Done".toUpperCase(),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}

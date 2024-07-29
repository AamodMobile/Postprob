import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/add_project/providers/add__post_provider.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';

class HashTagPupUp extends StatefulWidget {
  final AddPostProvider addPostProvider;

  const HashTagPupUp({super.key, required this.addPostProvider});

  @override
  State<HashTagPupUp> createState() => _LevelPupUpState();
}

class _LevelPupUpState extends State<HashTagPupUp> {
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
                CustomTextField(
                  hintText: "Add HashTag",
                  maxCheck: 4,
                  controller: widget.addPostProvider.hashTag,
                ),
                SizedBox(height: 25.h),
                CustomButtonWidget(
                  onPressed: () {
                    widget.addPostProvider.tags.add(widget.addPostProvider.hashTag.text);
                    widget.addPostProvider.hashTag.text="";
                    Navigator.pop(context,"200");
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

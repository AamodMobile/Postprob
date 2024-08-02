import 'package:image_picker/image_picker.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/column_spacer.dart';

class MediaSourcePicker extends StatelessWidget {
  const MediaSourcePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.dm),
      child: ColumnSpacer(
        spacerWidget: SizedBox(
          height: 12.h,
        ),
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     InkWell(
          //       onTap: () {},
          //       child: const Icon(Icons.close),
          //     )
          //   ],
          // ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop(ImageSource.gallery);
            },
            child: Row(
              children: [
                Container(
                  width: 35.h,
                  height: 35.h,
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF3F3F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Image.asset(
                    sendIc,
                    height: 20,
                    width: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Upload from Gallery",
                  style: TextStyle(
                    color: const Color(0xFF1B1B1B),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 0.10,
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop(ImageSource.camera);
            },
            child: Row(
              children: [
                Container(
                  width: 35.h,
                  height: 35.h,
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF3F3F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Image.asset(
                    sendIc,
                    height: 20,
                    width: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Take a picture",
                  style: TextStyle(
                    color: const Color(0xFF1B1B1B),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 0.10,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20.h)
        ],
      ),
    );
  }
}

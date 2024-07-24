import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/chat/models/message_list_model.dart';

class SenderChatItem extends StatefulWidget {
  final MessageListModel messageListModel;
  final bool file;

  const SenderChatItem({super.key, required this.messageListModel, required this.file});

  @override
  State<SenderChatItem> createState() => _SenderChatItemState();
}

class _SenderChatItemState extends State<SenderChatItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(left: 94.w),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.dm),
              topRight: Radius.circular(10.dm),
              bottomLeft: Radius.circular(10.dm),
              bottomRight: widget.file ? Radius.circular(10.dm) : Radius.circular(0.dm),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: widget.file
              ? Row(
                  children: [
                    Image.asset(
                      pdfIc,
                      height: 44.h,
                      width: 44.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.messageListModel.message.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: medium,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "867 Kb PDF",
                            style: TextStyle(
                              color: const Color(0xFFD0DBE0),
                              fontFamily: regular,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Image.asset(
                      optionsIc,
                      height: 24.h,
                      width: 24.w,
                      color: Colors.white,
                    ),
                  ],
                )
              : Text(
                  widget.messageListModel.message.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: medium,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
        ),
        SizedBox(height: 5.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.messageListModel.time.toString(),
              style: TextStyle(
                color: hintColor,
                fontFamily: regular,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
              ),
            ),
            SizedBox(width: 4.w),
            Image.asset(
              doubleClickIc,
              width: 14.w,
              height: 10.h,
              color: greenCl,
            )
          ],
        ),
      ],
    );
  }
}

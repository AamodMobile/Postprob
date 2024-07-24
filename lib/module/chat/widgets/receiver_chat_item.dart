import 'package:flutter/cupertino.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/chat/models/message_list_model.dart';

class ReceiverChatItem extends StatefulWidget {
  final MessageListModel messageListModel;

  const ReceiverChatItem({super.key, required this.messageListModel});

  @override
  State<ReceiverChatItem> createState() => _ReceiverChatItemState();
}

class _ReceiverChatItemState extends State<ReceiverChatItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 35.h,
              width: 35.w,
              padding: const EdgeInsets.all(0),
              decoration: const BoxDecoration(color: Color(0xFFD6CDFE), shape: BoxShape.circle),
              child: Image.asset(demoUser),
            ),
            SizedBox(width: 10.w),
            Flex(
              direction: Axis.horizontal,
              children: [Container(
                margin: const EdgeInsets.only(right: 85),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.dm),
                      topRight: Radius.circular(10.dm),
                      bottomRight: Radius.circular(10.dm),
                    )),
                child: Text(
                  widget.messageListModel.message.toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: blackCl,
                    fontFamily: medium,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),]
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: Text(
            widget.messageListModel.time.toString(),
            style: TextStyle(
              color: hintColor,
              fontFamily: regular,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontSize: 10.sp,
            ),
          ),
        ),
      ],
    );
  }
}

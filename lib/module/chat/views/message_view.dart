import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/core/common_widgets/media_source_picker.dart';
import 'package:postprob/core/utils/image_picker_utils.dart';
import 'package:postprob/module/chat/models/chat_model.dart';
import 'package:postprob/module/chat/widgets/receiver_chat_item.dart';
import 'package:postprob/module/chat/widgets/sender_chat_item.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  TextEditingController msg = TextEditingController();
  TextEditingController feedBack = TextEditingController();
  File image = File("");
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello sir, Good Morning", messageType: "sender", isFile: false),
    ChatMessage(messageContent: "Morning, Can i help you ?", messageType: "receiver", isFile: false),
    ChatMessage(messageContent: "I saw the UI/UX Designer vacancy that you uploaded on linkedin yesterday and I am interested in joining your company.", messageType: "sender", isFile: false),
    ChatMessage(messageContent: "Oh yes, please send your CV/Resume here", messageType: "receiver", isFile: false),
    ChatMessage(messageContent: "Jamet- CV - UI/UX Designer.PDF", messageType: "sender", isFile: true),
  ];
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        actions: [
          GestureDetector(
            onTap: () {
              showMenu(
                context: context,
                surfaceTintColor: Colors.white,
                color: Colors.white,
                elevation: 3,
                position: RelativeRect.fromLTRB(double.infinity, 60.h, 35.h, 0.w),
                items: [
                  PopupMenuItem<int>(
                    value: 1,
                    height: 36.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          size: 16.sp,
                          color: smallTextCl,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "Delete",
                          style: TextStyle(
                            color: smallTextCl,
                            fontFamily: regular,
                            fontSize: 14.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    height: 36.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.volume_off,
                          size: 16.sp,
                          color: smallTextCl,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "Mute",
                          style: TextStyle(
                            color: smallTextCl,
                            fontFamily: regular,
                            fontSize: 14.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // PopupMenuItem 3
                  PopupMenuItem<int>(
                    value: 3,
                    height: 36.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.block,
                          size: 16.sp,
                          color: smallTextCl,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "Block Chat",
                          style: TextStyle(
                            color: smallTextCl,
                            fontFamily: regular,
                            fontSize: 14.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).then((value) {
                if (value == 1) {
                } else if (value == 2) {
                } else if (value == 3) {}
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Image.asset(
                optionsIc,
                width: 24.h,
                height: 24.h,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
              color: Colors.white,
              height: 80.h,
              child: Row(
                children: [
                  Container(
                    height: 50.h,
                    width: 50.w,
                    padding: const EdgeInsets.all(0),
                    decoration: const BoxDecoration(color: Color(0xFFD6CDFE), shape: BoxShape.circle),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.dm),
                      child:Image.asset(demoUser),)
                  ),
                  SizedBox(width: 11.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Orlando Digs",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: mediumTextCl,
                            fontFamily: medium,
                            fontSize: 14.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 5.h,
                              width: 5.w,
                              decoration: const BoxDecoration(color: greenCl, shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "Online",
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: smallTextCl,
                                fontFamily: regular,
                                fontSize: 12.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (messages[index].messageType == "receiver" ? Alignment.topLeft : Alignment.topRight),
                        child: messages[index].messageType == "receiver"
                            ? ReceiverChatItem(msg: messages[index].messageContent)
                            : SenderChatItem(
                                msg: messages[index].messageContent,
                                file: messages[index].isFile,
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 76.h)
        ],
      ),
      bottomSheet: Container(
        color: const Color(0xFFF9F9F9),
        height: 75,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: msg,
                    hintText: 'Write your massage',
                    obscureText: false,
                    readOnly: false,
                    borderCl: Colors.white,
                    fillColor: Colors.white,
                    leading: InkWell(
                      onTap: () {
                        onPickAvatarTap(context);
                      },
                      child: Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            paperPinIc,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 9.w),
                InkWell(
                  onTap: () {
                    if (msg.text == "") {
                      errorToast(context, "Please enter msg");
                    } else {
                      setState(() {
                        messages.add(ChatMessage(messageContent: msg.text, messageType: "receiver", isFile: false));
                        msg.text = "";
                      });
                    }
                  },
                  child: Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.dm),
                      color: mainColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        sendFillIc,
                        height: 24.h,
                        width: 24.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h)
          ],
        ),
      ),
    ));
  }

  void onPickAvatarTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return const MediaSourcePicker();
      },
    ).then((value) async {
      if (value != null && value is ImageSource) {
        File? pickedFile = await PickImageUtility.instance(
          applyEditor: true,
          context: context,
        ).pickedFile(value);
        if (pickedFile != null) {
          image = pickedFile;
          var path = image.path;
        }
      }
    });
  }
}

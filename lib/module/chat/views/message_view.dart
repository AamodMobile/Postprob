import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/core/common_widgets/loader_class.dart';
import 'package:postprob/core/common_widgets/media_source_picker.dart';
import 'package:postprob/core/utils/image_picker_utils.dart';
import 'package:postprob/module/chat/models/chat_list_model.dart';
import 'package:postprob/module/chat/providers/chat_list_provider.dart';
import 'package:postprob/module/chat/widgets/receiver_chat_item.dart';
import 'package:postprob/module/chat/widgets/sender_chat_item.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_url.dart';

class MessageView extends StatefulWidget {
  final String id;
  final String userId;
  final Recipient user;

  const MessageView({
    super.key,
    required this.id,
    required this.user,
    required this.userId,
  });

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late ChatListProvider chatListProvider;

  @override
  void initState() {
    super.initState();
    chatListProvider = context.read<ChatListProvider>();
    chatListProvider.files.clear();
    chatListProvider.otherUserId = widget.id;
    chatListProvider.currentPage = 1;
    chatListProvider.getMessages(true, isFast: true).then((value) {
      chatListProvider.initializePusher();
    });
    chatListProvider.setupScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatListProvider>(
      builder: (context, state, child) {
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
                                state.isMute == "0" ? Icons.volume_off : Icons.volume_down,
                                size: state.isMute == "0" ? 16.sp : 18.sp,
                                color: smallTextCl,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                state.isMute == "0" ? "Mute" : "UnMute",
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
                          value: 3,
                          height: 36.h,
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                          child: Row(
                            children: [
                              Icon(
                                state.isBlock == "0" ? Icons.block : Icons.check,
                                size: 16.sp,
                                color: smallTextCl,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                state.isBlock == "0" ? "Block Chat" : "Unblock Chat",
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
                        chatListProvider.clearAllMessages(context, chatListProvider.eventId);
                      } else if (value == 2) {
                        if (state.isMute == "0") {
                          state.muteChat(context, "1");
                        } else {
                          state.muteChat(context, "0");
                        }
                      } else if (value == 3) {
                        if (state.isBlock == "0") {
                          state.blockChat(context, "1");
                        } else {
                          state.blockChat(context, "0");
                        }
                      }
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
                preferredSize: Size.fromHeight(70.h),
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
                        decoration: const BoxDecoration(
                          color: Color(0xFFD6CDFE),
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.dm),
                          child: widget.user.image != ""
                              ? CachedNetworkImage(
                                  errorWidget: (context, url, error) => Image.asset(
                                    demoUser,
                                    height: 50.h,
                                    width: 50.w,
                                    fit: BoxFit.cover,
                                  ),
                                  height: 50.h,
                                  width: 50.w,
                                  fit: BoxFit.cover,
                                  imageUrl: ApiUrl.imageUrl + widget.user.image.toString(),
                                  placeholder: (a, b) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Image.asset(demoUser),
                        ),
                      ),
                      SizedBox(width: 11.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.user.name.toString(),
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
                                  decoration: const BoxDecoration(
                                    color: greenCl,
                                    shape: BoxShape.circle,
                                  ),
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
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                SizedBox(height: 10.h),
                Builder(builder: (context) {
                  if (state.isLoading) {
                    return LoaderClass(height: MediaQuery.of(context).size.height - 300);
                  }
                  if (state.messageList.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60.h,
                        ),
                        Image.asset(
                          noMessage,
                          height: 240.h,
                          width: 240.w,
                        ),
                        SizedBox(height: 42.h),
                        Text(
                          "No Message",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: blackCl,
                            fontFamily: medium,
                            fontSize: 16.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 45.w),
                          child: Text(
                            "You currently have no incoming messages thank you",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: smallTextCl,
                              fontFamily: regular,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 77.h),
                      ],
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      controller: chatListProvider.scrollController,
                      itemCount: state.messageList.length,
                      shrinkWrap: true,
                      reverse: false,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                              child: Align(
                                alignment: (state.messageList[index].isSender.toString() == "0" ? Alignment.topLeft : Alignment.topRight),
                                child: state.messageList[index].isSender.toString() == "0"
                                    ? ReceiverChatItem(
                                        messageListModel: state.messageList[index],
                                        file: state.messageList[index].filePath!.isEmpty ? false : true,
                                        image: widget.user.image.toString(),
                                      )
                                    : SenderChatItem(messageListModel: state.messageList[index], file: state.messageList[index].filePath!.isEmpty ? false : true),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }),
                SizedBox(height: 76.h)
              ],
            ),
            bottomSheet: state.isBlock == "1"
                ? Container(
                    color: const Color(0xFFF9F9F9),
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 15.h),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Chat Block",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: blackCl,
                        fontFamily: medium,
                        fontSize: 16.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : Container(
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
                                controller: state.msg,
                                hintText: 'Write your message',
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
                                if (state.msg.text == "") {
                                  errorToast(context, "Please enter msg");
                                } else {
                                  state.sendMessage(context, state.msg.text).then((value) {
                                    chatListProvider.scrollToBottom();
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
          ),
        );
      },
    );
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
          chatListProvider.image = pickedFile;
          var path = chatListProvider.image.path;
          chatListProvider.files.add(chatListProvider.image);
          Log.console(path);
        }
      }
    });
  }
}

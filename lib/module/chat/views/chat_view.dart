import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/core/common_widgets/loader_class.dart';
import 'package:postprob/module/chat/providers/chat_list_provider.dart';
import 'package:postprob/module/chat/views/message_view.dart';
import 'package:postprob/services/api_url.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late ChatListProvider chatListProvider;
  bool isEmpty = false;

  @override
  void initState() {
    chatListProvider = context.read<ChatListProvider>();
    chatListProvider.chatListGet(context, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatListProvider>(
      builder: (context, state, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),
            appBar: state.isLoading
                ? null
                : state.chatList.isEmpty
                    ? null
                    : AppBar(
                        backgroundColor: const Color(0xFFF9F9F9),
                        automaticallyImplyLeading: false,
                        centerTitle: true,
                        elevation: 0,
                        title: Text(
                          "Messages",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: blackCl,
                            fontFamily: semiBold,
                            fontSize: 20.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        actions: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  writeIc,
                                  width: 24.h,
                                  height: 24.h,
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Image.asset(
                                  optionsIc,
                                  width: 24.h,
                                  height: 24.h,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Builder(
                builder: (context) {
                  if (state.isLoading) {
                    return LoaderClass(height: MediaQuery.of(context).size.height - 200);
                  }
                  if (state.chatList.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width, height: 100.h),
                        Image.asset(
                          noSaveImg,
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.07),
                          child: CustomButtonWidget(
                            onPressed: () {},
                            text: "CREATE A MESSAGE",
                          ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      SizedBox(height: 24.h),
                      CustomTextField(
                        hintText: "Search message",
                        fillColor: Colors.white,
                        leading: Image.asset(
                          searchIc,
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                      SizedBox(height: 35.h),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: state.chatList.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    createRightToLeftRoute(MessageView(
                                      id: state.chatList[index].recipient!.id.toString(),
                                      user: state.chatList[index].recipient!,
                                      userId: state.chatList[index].userId.toString(),
                                    )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 25.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 50.w,
                                      padding: const EdgeInsets.all(0),
                                      decoration: const BoxDecoration(color: Color(0xFFD6CDFE), shape: BoxShape.circle),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25.dm),
                                        child: state.chatList[index].recipient != null && state.chatList[index].recipient!.image != ""
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(20.dm),
                                                child: CachedNetworkImage(
                                                  errorWidget: (context, url, error) => Image.asset(
                                                    demoUser,
                                                    height: 50.h,
                                                    width: 50.w,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  height: 50.h,
                                                  width: 50.w,
                                                  fit: BoxFit.cover,
                                                  imageUrl: ApiUrl.imageUrl + state.chatList[index].recipient!.image.toString(),
                                                  placeholder: (a, b) => const Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                ),
                                              )
                                            : Image.asset(demoUser),
                                      ),
                                    ),
                                    SizedBox(width: 15.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.chatList[index].recipient != null ? state.chatList[index].recipient!.name.toString() : "",
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
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          Text(
                                            state.chatList[index].message.toString(),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: state.chatList[index].unreadCount != 0
                                                ? TextStyle(
                                                    color: smallTextCl,
                                                    fontFamily: medium,
                                                    fontSize: 12.sp,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w700,
                                                  )
                                                : TextStyle(
                                                    color: hintColor,
                                                    fontFamily: regular,
                                                    fontSize: 12.sp,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          _getTimeAgo(state.chatList[index].createdAt!, DateTime.now()),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: hintColor,
                                            fontFamily: regular,
                                            fontSize: 12.sp,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        state.chatList[index].unreadCount != 0
                                            ? Container(
                                                padding: EdgeInsets.all(4.w),
                                                decoration: const BoxDecoration(color: yellowDark, shape: BoxShape.circle),
                                                child: Text(
                                                  state.chatList[index].unreadCount.toString(),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: regular,
                                                    fontSize: 9.sp,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  String _getTimeAgo(DateTime from, DateTime to) {
    Duration diff = to.difference(from);
    if (diff.inMinutes < 1) {
      return 'just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} h ago';
    } else if (diff.inDays < 30) {
      return '${diff.inDays} d ago';
    } else if (diff.inDays < 365) {
      int months = (diff.inDays / 30).floor();
      return '$months ${months == 1 ? "month" : "months"} ago';
    } else {
      int years = (diff.inDays / 365).floor();
      return '$years ${years == 1 ? "year" : "years"} ago';
    }
  }
}

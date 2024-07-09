import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/common_widgets/custom_buttons.dart';
import 'package:postprob/core/common_widgets/custom_input_fields.dart';
import 'package:postprob/module/chat/views/message_view.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: isEmpty
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
                      )),
                ],
              ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: isEmpty
              ? Column(
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
                )
              : Column(
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
                        itemCount: 12,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, createRightToLeftRoute(const MessageView()));
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
                                      child:Image.asset(demoUser),
                                  ),),
                                  SizedBox(width: 15.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Andy Robertson",
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
                                          "Oh yes, please send your CV/Res...",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: index == 0
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
                                        "5m ago",
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
                                      index == 0
                                          ? Container(
                                              padding: EdgeInsets.all(4.w),
                                              decoration: const BoxDecoration(color: yellowDark, shape: BoxShape.circle),
                                              child: Text(
                                                "2",
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
                ),
        ),
      ),
    );
  }
}

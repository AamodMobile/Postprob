import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/chat/models/message_list_model.dart';
import 'package:postprob/services/api_url.dart';

class ReceiverChatItem extends StatefulWidget {
  final MessageListModel messageListModel;
  final bool file;
  final String image;

  const ReceiverChatItem({super.key, required this.messageListModel, required this.file, required this.image});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 35,
              width: 35,
              padding: const EdgeInsets.all(0),
              decoration: const BoxDecoration(color: Color(0xFFD6CDFE), shape: BoxShape.circle),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: widget.image != ""
                    ? CachedNetworkImage(
                        errorWidget: (context, url, error) => Image.asset(
                          demoUser,
                          height: 35,
                          width: 35,
                          fit: BoxFit.cover,
                        ),
                        height: 35,
                        width: 35,
                        fit: BoxFit.cover,
                        imageUrl: ApiUrl.imageUrl + widget.image.toString(),
                        placeholder: (a, b) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Image.asset(demoUser),
              ),
            ),
            SizedBox(width: 10.w),
            Container(
                margin:  EdgeInsets.only(right: 45.w),
                child: IntrinsicWidth(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 50.0, maxWidth: MediaQuery.of(context).size.width * 0.65),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.dm),
                            topRight: Radius.circular(10.dm),
                            bottomRight: Radius.circular(10.dm),
                          )),
                      child: widget.file
                          ? widget.messageListModel.filePath?.length == 1
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        widget.messageListModel.filePath!.isNotEmpty
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: CachedNetworkImage(
                                                  errorWidget: (context, url, error) => Image.asset(
                                                    pdfIc,
                                                    height: 44.h,
                                                    width: 44.w,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  height: 44.h,
                                                  width: 44.w,
                                                  fit: BoxFit.cover,
                                                  imageUrl: ApiUrl.imageUrl + widget.messageListModel.filePath![0].toString(),
                                                  placeholder: (a, b) => const Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                ),
                                              )
                                            : Image.asset(
                                                pdfIc,
                                                height: 44.h,
                                                width: 44.w,
                                              ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
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
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      widget.messageListModel.message.toString() + demoString,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: medium,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Image.asset(
                                      pdfIc,
                                      height: 44.h,
                                      width: 44.w,
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.messageListModel.message.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
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
                                      color: Colors.black,
                                    ),
                                  ],
                                )
                          : IntrinsicWidth(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(minWidth: 30.0, maxWidth: MediaQuery.of(context).size.width * 0.6),
                                child: Text(
                                  widget.messageListModel.message.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: medium,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.w),
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

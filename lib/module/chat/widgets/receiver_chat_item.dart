import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/chat/models/message_list_model.dart';
import 'package:postprob/module/chat/views/full_image_view.dart';
import 'package:postprob/module/chat/views/video_item.dart';
import 'package:postprob/module/chat/views/web_view_.dart';
import 'package:postprob/services/api_url.dart';

class ReceiverChatItem extends StatefulWidget {
  final MessageListModel messageListModel;
  final String image;
  final bool file;
  final bool images;
  final bool video;

  const ReceiverChatItem({super.key, required this.messageListModel, required this.file, required this.image, required this.images, required this.video});

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
              margin: EdgeInsets.only(right: 45.w),
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
                    child: widget.images && widget.file && widget.video
                        ? widget.messageListModel.photos?.length == 1
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      widget.messageListModel.photos!.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context, createRightToLeftRoute(FullImageView(image: "${ApiUrl.imageUrl}${widget.messageListModel.photos![0].toString()}")));
                                                },
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
                                                  imageUrl: ApiUrl.imageUrl + widget.messageListModel.photos![0].toString(),
                                                  placeholder: (a, b) => const Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                ),
                                              ))
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
                                  widget.messageListModel.filePath != null && widget.messageListModel.filePath!.isNotEmpty
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 5.h),
                                            Text(
                                              "Doc",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: medium,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, createRightToLeftRoute(WebViewScreen(url: "${ApiUrl.imageUrl}${widget.messageListModel.filePath![0].toString()}")));
                                              },
                                              child: Row(
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
                                                          widget.messageListModel.filePath![0].toString(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: medium,
                                                            fontStyle: FontStyle.normal,
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      : const SizedBox(),
                                  widget.messageListModel.videos != null && widget.messageListModel.videos!.isNotEmpty
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 5.h),
                                            Text(
                                              "Video",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: medium,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  createRightToLeftRoute(
                                                    VideoPlayerItem(
                                                      videoUrl: "${ApiUrl.imageUrl}${widget.messageListModel.videos![0].toString()}",
                                                      isPaused: false,
                                                      videoId: 1,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(5),
                                                    child: Stack(
                                                      children: [
                                                        Image.asset(
                                                          videoDemoImg,
                                                          height: 44.h,
                                                          width: 65.w,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          bottom: 0,
                                                          right: 0,
                                                          left: 0,
                                                          child: Center(
                                                            child: Image.asset(
                                                              playIc,
                                                              height: 24.h,
                                                              width: 24.w,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          widget.messageListModel.videos![0].toString(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: medium,
                                                            fontStyle: FontStyle.normal,
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      : const SizedBox()
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
                        : widget.images
                            ? widget.messageListModel.photos?.length == 1
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          widget.messageListModel.photos!.isNotEmpty
                                              ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context, createRightToLeftRoute(FullImageView(image: "${ApiUrl.imageUrl}${widget.messageListModel.photos![0].toString()}")));
                                                    },
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
                                                      imageUrl: ApiUrl.imageUrl + widget.messageListModel.photos![0].toString(),
                                                      placeholder: (a, b) => const Center(
                                                        child: CircularProgressIndicator(),
                                                      ),
                                                    ),
                                                  ))
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
                            : widget.file
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
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
                                      widget.messageListModel.filePath!.isNotEmpty
                                          ? Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 5.h),
                                                Text(
                                                  "Doc",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: medium,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                SizedBox(height: 5.h),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context, createRightToLeftRoute(WebViewScreen(url: "${ApiUrl.imageUrl}${widget.messageListModel.filePath![0].toString()}")));
                                                  },
                                                  child: Row(
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
                                                              widget.messageListModel.filePath![0].toString(),
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontFamily: medium,
                                                                fontStyle: FontStyle.normal,
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 14.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          : const SizedBox()
                                    ],
                                  )
                                : widget.video
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
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
                                          widget.messageListModel.videos!.isNotEmpty
                                              ? Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 5.h),
                                                    Text(
                                                      "Video",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: medium,
                                                        fontStyle: FontStyle.normal,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          createRightToLeftRoute(
                                                            VideoPlayerItem(
                                                              videoUrl: "${ApiUrl.imageUrl}${widget.messageListModel.videos![0].toString()}",
                                                              isPaused: false,
                                                              videoId: 1,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.circular(5),
                                                            child: Stack(
                                                              children: [
                                                                Image.asset(
                                                                  videoDemoImg,
                                                                  height: 44.h,
                                                                  width: 65.w,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                                Positioned(
                                                                  top: 0,
                                                                  bottom: 0,
                                                                  right: 0,
                                                                  left: 0,
                                                                  child: Center(
                                                                    child: Image.asset(
                                                                      playIc,
                                                                      height: 24.h,
                                                                      width: 24.w,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  widget.messageListModel.videos![0].toString(),
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontFamily: medium,
                                                                    fontStyle: FontStyle.normal,
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize: 14.sp,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : const SizedBox()
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

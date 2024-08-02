import 'package:cached_network_image/cached_network_image.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/chat/models/message_list_model.dart';
import 'package:postprob/module/chat/views/full_image_view.dart';
import 'package:postprob/module/chat/views/video_item.dart';
import 'package:postprob/module/chat/views/web_view_.dart';
import 'package:postprob/services/api_url.dart';

class SenderChatItem extends StatefulWidget {
  final MessageListModel messageListModel;
  final bool file;
  final bool image;
  final bool video;

  const SenderChatItem({super.key, required this.messageListModel, required this.file, required this.image, required this.video});

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
          margin: EdgeInsets.only(left: 64.w),
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
          child: widget.image && widget.file && widget.video
              ? widget.messageListModel.photos?.length == 1
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            widget.messageListModel.photos!.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, createRightToLeftRoute(FullImageView(image: "${ApiUrl.imageUrl}${widget.messageListModel.photos![0].toString()}")));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.dm),
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
                                    ),
                                  )
                                : Image.asset(
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
                        ),
                        widget.messageListModel.filePath != null && widget.messageListModel.filePath!.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5.h),
                                  Text(
                                    "Doc",
                                    style: TextStyle(
                                      color: Colors.white,
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
                                                  color: Colors.white,
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
                                      color: Colors.white,
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
                                                  color: Colors.white,
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
              : widget.image
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            widget.messageListModel.photos!.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, createRightToLeftRoute(FullImageView(image: "${ApiUrl.imageUrl}${widget.messageListModel.photos![0].toString()}")));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.dm),
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
                                    ),
                                  )
                                : Image.asset(
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
                                          color: Colors.white,
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
                                  color: Colors.white,
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
                                          color: Colors.white,
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
                                                      color: Colors.white,
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
                                              color: Colors.white,
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
                                      color: Colors.white,
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
                                              color: Colors.white,
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
                                              ); },
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
                                                          color: Colors.white,
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

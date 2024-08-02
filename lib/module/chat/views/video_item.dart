import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:video_player/video_player.dart';

VideoPlayerController? reelsPlayerController;
bool shouldAutoPlayReel = true;

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final bool isPaused;
  final int videoId;
  final VoidCallback? callback;

  const VideoPlayerItem({super.key, required this.videoUrl, required this.isPaused, required this.videoId, this.callback});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController? _videoPlayerController;
  bool isLoading = true;
  bool initialized = false;
  bool isBuffering = false;
  String? errorText;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(Uri.parse(widget.videoUrl).toString());
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      await _videoPlayerController!.initialize();

      if (mounted) {
        setState(() {
          isLoading = false;
          initialized = true;
        });
        if (shouldAutoPlayReel) {
          _videoPlayerController!.play();
        }
        _videoPlayerController!.setLooping(true);
        _videoPlayerController!.setVolume(1);
        _videoPlayerController!.addListener(() {
          if (_videoPlayerController!.value.isBuffering) {
            if (mounted) {
              setState(() {
                isBuffering = true;
              });
            }
          } else {
            if (mounted && isBuffering) {
              setState(() {
                isBuffering = false;
              });
            }
          }
        });
      }
    } catch (error) {
      Navigator.pop(context);
      errorToast(context, "Video Can't Play Please check SSL Server");
    }
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }

  _saveNetworkVideo(BuildContext context) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        var appDocDir = await getTemporaryDirectory();
        String savePath = "${appDocDir.path}/temp.mp4";
        String fileUrl = widget.videoUrl;
        await Dio().download(fileUrl, savePath, onReceiveProgress: (count, total) {
          Log.console("${(count / total * 100).toStringAsFixed(0)}%");
        });
        final result = await ImageGallerySaver.saveFile(savePath);
        if (context.mounted) {
          if (result != null) {
            successToast(context, 'Gallery updated');
          } else {
            errorToast(context, 'Error updating gallery');
          }
        }
      } catch (e) {
        if (context.mounted) {
          errorToast(context, 'Error downloading video: $e');
        }
      }
    } else {
      if (context.mounted) {
        errorToast(context, 'Permission denied');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgCl,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: bgCl,
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
              _saveNetworkVideo(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Icon(
                Icons.download,
                color: mainColor,
                size: 30.h,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (errorText != null)
              Center(
                child: Text(
                  errorText!,
                  style: const TextStyle(color: Colors.red),
                ),
              )
            else if (isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            else
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: VideoPlayer(_videoPlayerController!),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    _videoPlayerController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  onPressed: () {
                    if (_videoPlayerController!.value.isPlaying) {
                      _videoPlayerController!.pause();
                    } else {
                      _videoPlayerController!.play();
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
            Visibility(
              visible: isBuffering,
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const WidgetSpan(child: CircularProgressIndicator()),
                      TextSpan(
                        text: '\n\nLoading',
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                          shadows: [
                            const Shadow(
                              color: Colors.white,
                              offset: Offset(0, 0),
                              blurRadius: 30,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

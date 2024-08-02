import 'dart:io';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/services/api_logs.dart';

class FullImageView extends StatefulWidget {
  final String image;

  const FullImageView({super.key, required this.image});

  @override
  State<FullImageView> createState() => _FullImageViewState();
}

class _FullImageViewState extends State<FullImageView> {
  final GlobalKey _globalKey = GlobalKey();

  saveLocalImage() async {
    RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      Log.console(result);
    }
  }

  _saveNetworkImage(BuildContext context) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        var response = await Dio().get(widget.image, options: Options(responseType: ResponseType.bytes));
        final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 60, name: "hello");
        if (context.mounted) {
          if (result != null) {
            successToast(context, 'Gallery updated');
          } else {
            errorToast(context, 'Error updating gallery');
          }
        }
      } catch (e) {
        if (context.mounted) {
          errorToast(context, 'Error downloading image: $e');
        }
      }
    } else {
      if (context.mounted) {
        errorToast(context, 'Permission denied');
      }
    }
  }

  Future<void> downloadImage(BuildContext context) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final directory = await getExternalStorageDirectory();
      Log.console(directory);
      const path = '/storage/emulated/0/Download/Postprob_images';
      final dir = Directory(path);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      final filePath = '$path/${DateTime.now().millisecondsSinceEpoch}.jpg';
      try {
        await Dio().download(widget.image, filePath);
        if (context.mounted) {
          successToast(context, 'Image saved to $filePath');
        }
        final result = await Process.run('am', ['broadcast', '-a', 'android.intent.action.MEDIA_SCANNER_SCAN_FILE', '-d', 'file://$filePath']);
        if (context.mounted) {
          if (result.exitCode == 0) {
            successToast(context, 'Gallery updated');
          } else {
            errorToast(context, 'Error updating gallery');
          }
        }
      } catch (e) {
        if (context.mounted) {
          errorToast(context, 'Error downloading image: $e');
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
    return SafeArea(
      child: Scaffold(
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
                _saveNetworkImage(context);
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.dm),
                  child: widget.image != ""
                      ? CachedNetworkImage(
                          errorWidget: (context, url, error) => Image.asset(
                            demoUser,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.contain,
                          ),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain,
                          imageUrl: widget.image.toString(),
                          placeholder: (a, b) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Image.asset(
                          demoUser,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

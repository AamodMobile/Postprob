import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool _documentLoadFailed = false;
  bool downloading = false;

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
                if (!downloading) {
                  downloadPdf(context);
                }
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
        body: _documentLoadFailed
            ? Center(
                child: Text(
                  "No data found",
                  style: TextStyle(color: mainColor, fontFamily: bold, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14.sp),
                ),
              )
            : SfPdfViewer.network(
                widget.url,
                onDocumentLoadFailed: (error) {
                  setState(() {
                    _documentLoadFailed = true;
                  });
                },
                pageSpacing: 0,
              ),
      ),
    );
  }

  Future<void> downloadPdf(BuildContext context) async {
    String? selectedFolder;
    try {
      selectedFolder = await FilePicker.platform.getDirectoryPath();
      if (selectedFolder == null) return; // User canceled
    } catch (e) {
      if (context.mounted) {
        Log.console('Error picking directory: $e');
        errorToast(context, 'Error picking directory: $e');
      }
      return;
    }
    String pdfUrl = widget.url;
    String fileName = pdfUrl.split('/').last;
    String filePath = '$selectedFolder/$fileName';
    try {
      Dio dio = Dio();
      await dio.download(
        pdfUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = (received / total) * 100;
            Log.console('Download progress: $progress%');
            if (progress == 100.0) {
              //Navigator.of(context).pop();
              showDownloadSuccessDialog(context, filePath);
            } else {
              //DownloadProgressDialog(context, 'Downloading...', progress);
            }
          }
        },
      );
    } catch (e) {
      Log.console('Error downloading PDF: $e');
      if (context.mounted) {
        errorToast(context, 'Error downloading PDF: $e');
      }
    }
  }

  void showDownloadSuccessDialog(BuildContext context, String filePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('File Downloaded'),
          content: Text('File downloaded to:\n$filePath'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void downloadProgressDialog(BuildContext context, String message, double progress) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(
                value: progress / 100,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              const SizedBox(height: 16),
              Text('${progress.toStringAsFixed(2)}%'),
            ],
          ),
        );
      },
    );
  }
}

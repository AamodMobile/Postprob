import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/connection/models/post_deatils_model.dart';
import 'package:postprob/module/connection/models/post_list_model.dart';
import 'package:postprob/module/connection/models/success_model.dart';
import 'package:postprob/module/job_view/view/successful_apply_view.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';

class ConnectionProvider extends ChangeNotifier {
  var connectionList = <PostListModel>[];
  bool isLoading = false;
  bool noData = false;
  var postDetailsModel = PostDetailsModel();
  var successModel = SuccessModel();
  String selectedFilePath = "";
  int? fileSize;
  DateTime? fileDate;
  TextEditingController info = TextEditingController();

  Future<void> uploadPDFFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      selectedFilePath = result.files.single.path.toString();
      fileSize = File(selectedFilePath).lengthSync();
      fileDate = File(selectedFilePath).lastModifiedSync();
      notifyListeners();
    } else {
      if (context.mounted) {
        errorToast(context, "Not pick file");
      }
    }
  }

  void removeSelectedFile() {
    selectedFilePath = "";
    fileSize = null;
    fileDate = null;
    info.text = "";
    notifyListeners();
  }

  void reset() {
    selectedFilePath = "";
    fileSize = null;
    fileDate = null;
    info.text = "";
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy \'at\' hh:mm a').format(dateTime);
  }

  Future<void> getPostList(BuildContext context, bool isLoad) async {
    try {
      if (isLoad) {
        isLoading = true;
      }
      var result = await ApiService.postListGet();
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          if (isLoad) {
            await Future.delayed(const Duration(seconds: 3)).then((value) {
              isLoading = false;
              connectionList.clear();
              connectionList = List<PostListModel>.from(json["data"].map((i) => PostListModel.fromJson(i))).toList(growable: true);
            });
          } else {
            connectionList.clear();
            connectionList = List<PostListModel>.from(json["data"].map((i) => PostListModel.fromJson(i))).toList(growable: true);
          }
        } else {
          isLoading = false;
          errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> getPostDetails(BuildContext context, String postId) async {
    try {
      isLoading = true;
      var result = await ApiService.postDetailGet(postId);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          await Future.delayed(const Duration(seconds: 3)).then((value) {
            isLoading = false;
            noData = false;
            postDetailsModel = PostDetailsModel.fromJson(json["data"]);
          });
        } else {
          isLoading = false;
          noData = true;
          errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      isLoading = false;
      noData = true;
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> jobApply(BuildContext context, String postId, String info) async {
    try {
      showProgress(context);
      var result = await ApiService.jobApply(postId, selectedFilePath, info);
      if (context.mounted) {
        if (result["status"] == true) {
          await Future.delayed(const Duration(seconds: 1)).then((value) {
            successModel = SuccessModel.fromJson(result["data"]);
            closeProgress(context);
            Navigator.pushAndRemoveUntil(
              context,
              createRightToLeftRoute(const SuccessfulApplyView()),
              (route) => false,
            );
          });
        } else {
          closeProgress(context);
          errorToast(context, result["message"].toString());
        }
      }
    } catch (e) {
      if (context.mounted) {
        closeProgress(context);
        Log.console(e.toString());
      }
    }
    notifyListeners();
  }

  Future<void> savePost(BuildContext context, String postId) async {
    try {
      showProgress(context);
      var result = await ApiService.savePost(postId);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          getPostList(context, false);
          closeProgress(context);
          successToast(context, json["message"].toString());
        } else {
          closeProgress(context);
          errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      if (context.mounted) {
        closeProgress(context);
      }
      Log.console(e.toString());
    }
    //notifyListeners();
  }

  Future<void> removeSavedPost(BuildContext context, String postId) async {
    try {
      showProgress(context);
      var result = await ApiService.removeSavedPost(postId,"single");
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          getPostList(context, false);
          closeProgress(context);
          successToast(context, json["message"].toString());
        } else {
          closeProgress(context);
          errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      if (context.mounted) {
        closeProgress(context);
      }
      Log.console(e.toString());
    }
    //notifyListeners();
  }
}

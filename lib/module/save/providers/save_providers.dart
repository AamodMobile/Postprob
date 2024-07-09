import 'dart:convert';

import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/connection/models/post_list_model.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';

class SavePostProvider extends ChangeNotifier {
  var savePostList = <PostListModel>[];
  bool isLoading = false;

  Future<void> savedPostsList(BuildContext context, bool isLoad) async {
    try {
      if (isLoad) {
        isLoading = true;
      }
      var result = await ApiService.savedPostsList();
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          if (isLoad) {
            await Future.delayed(const Duration(seconds: 3)).then((value) {
              isLoading = false;
              savePostList.clear();
              savePostList = List<PostListModel>.from(json["data"].map((i) => PostListModel.fromJson(i))).toList(growable: true);
            });
          } else {
            savePostList.clear();
            savePostList = List<PostListModel>.from(json["data"].map((i) => PostListModel.fromJson(i))).toList(growable: true);
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

  Future<void> savePost(BuildContext context, String postId) async {
    try {
      showProgress(context);
      var result = await ApiService.savePost(postId);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          savedPostsList(context, false);
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

  Future<void> removeSavedPost(BuildContext context, String postId,String type) async {
    try {
      showProgress(context);
      var result = await ApiService.removeSavedPost(postId,type);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          savedPostsList(context, false);
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

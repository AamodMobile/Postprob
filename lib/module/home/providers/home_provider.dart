import 'dart:convert';

import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/connection/models/post_list_model.dart';
import 'package:postprob/module/home/banner_model/banner_model.dart';
import 'package:postprob/module/profile/models/profile_model.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;
  ProfileModel profileModel = ProfileModel();
  List bannerList = <BannerModel>[];
  List posts = <PostListModel>[];
  String postCounts = "";
  String fullTimePosts = "";
  String partTimePosts = "";

  Future<void> userGetProfile(BuildContext context) async {
    try {
      isLoading = true;
      var result = await ApiService.userGetProfile();
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          isLoading = false;
          profileModel = ProfileModel.fromJson(json["data"]);
        } else {
          isLoading = false;
          errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      if (context.mounted) {
        isLoading = false;
        Log.console(e.toString());
      }
    }
    notifyListeners();
  }

  Future<void> getHomeDataApi(BuildContext context) async {
    try {
      isLoading = true;
      var result = await ApiService.getHomeDataApi();
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          isLoading = false;
          bannerList = List<BannerModel>.from(json["banner"].map((i) => BannerModel.fromJson(i))).toList(growable: true);
          postCounts = json["post_counts"].toString();
          fullTimePosts = json["full_time_posts"].toString();
          partTimePosts = json["part_time_posts"].toString();
          posts = List<PostListModel>.from(json["posts"]!.map((x) => PostListModel.fromJson(x))).toList(growable: true);
        } else {
          isLoading = false;
          errorToast(context, json["message"].toString());
        }
      }
    } catch (e) {
      if (context.mounted) {
        isLoading = false;
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
          getHomeDataApi(context);
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
          getHomeDataApi(context);
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

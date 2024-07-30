import 'dart:convert';

import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/your_application/models/applied_jobs_model.dart';
import 'package:postprob/module/your_post_application/models/my_post_job_details_model.dart';
import 'package:postprob/module/your_post_application/models/post_jobs_model.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';

class PostApplicationProvider extends ChangeNotifier{
  var postJobsList = <PostJobsListModel>[];
  bool isLoading = false;
  bool noData = false;
  var myPostDetails = MyPostJobDetailsModel();

  Future<void> getPostJobsList(BuildContext context) async {
    try {
      isLoading = true;
      postJobsList.clear();
      var result = await ApiService.myPosts();
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          await Future.delayed(const Duration(seconds: 3)).then((value) {
            isLoading = false;
            postJobsList = List<PostJobsListModel>.from(json["data"].map((i) => PostJobsListModel.fromJson(i))).toList(growable: true);
          });
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

  Future<void> getPostJobDetail(BuildContext context, String appliedJobId) async {
    try {
      isLoading = true;
      var result = await ApiService.myPostDetail(appliedJobId);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          await Future.delayed(const Duration(seconds: 3)).then((value) {
            isLoading = false;
            noData = false;
            myPostDetails = MyPostJobDetailsModel.fromJson(json["data"]);
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
}
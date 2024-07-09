import 'dart:convert';

import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/your_application/models/applied_jobs_model.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';

class AppliedJobProvider extends ChangeNotifier {
  var appliedJobsList = <AppliedJobsModel>[];
  bool isLoading = false;
  bool noData = false;
  var applyJobDetails = AppliedJobsModel();

  Future<void> getAppliedJobsList(BuildContext context) async {
    //try {
      isLoading = true;
      appliedJobsList.clear();
      var result = await ApiService.appliedJobsList();
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          await Future.delayed(const Duration(seconds: 3)).then((value) {
            isLoading = false;
            appliedJobsList = List<AppliedJobsModel>.from(json["data"].map((i) => AppliedJobsModel.fromJson(i))).toList(growable: true);
          });
        } else {
          isLoading = false;
          errorToast(context, json["message"].toString());
        }
      }
    //} catch (e) {
   //   isLoading = false;
   //   Log.console(e.toString());
  //  }
    notifyListeners();
  }

  Future<void> getAppliedJobDetail(BuildContext context, String appliedJobId) async {
    try {
      isLoading = true;
      var result = await ApiService.appliedJobDetail(appliedJobId);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          await Future.delayed(const Duration(seconds: 3)).then((value) {
            isLoading = false;
            noData = false;
            applyJobDetails = AppliedJobsModel.fromJson(json["data"]);
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

import 'dart:convert';

import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/profile/models/list_data_model.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';

class ProfileProvider extends ChangeNotifier {
  bool isLoading = false;
  var categoryList = <ListDataModel>[];
  var languageList = <ListDataModel>[];
  var workplaceList = <ListDataModel>[];
  var skillsList = <ListDataModel>[];
  var educationLevelList = <ListDataModel>[];
  var languageLevelList = <ListDataModel>[];

  Future<void> getCategoryList(BuildContext context) async {
    try {
      isLoading = true;
      categoryList.clear();
      var result = await ApiService.getCategoryListApi();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        categoryList = List<ListDataModel>.from(json['data'].map((i) => ListDataModel.fromJson(i))).toList(growable: true);
      } else {
        errorToast(context, json["status"].toString());
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> getLanguageList(BuildContext context) async {
    try {
      isLoading = true;
      languageList.clear();
      var result = await ApiService.getLanguageListApi();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        languageList = List<ListDataModel>.from(json['data'].map((i) => ListDataModel.fromJson(i))).toList(growable: true);
      } else {
        errorToast(context, json["status"].toString());
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> getWorkplaceList(BuildContext context) async {
    try {
      isLoading = true;
      workplaceList.clear();
      var result = await ApiService.getWorkplaceListApi();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        workplaceList = List<ListDataModel>.from(json['data'].map((i) => ListDataModel.fromJson(i))).toList(growable: true);
      } else {
        errorToast(context, json["status"].toString());
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> getSkillsList(BuildContext context) async {
    try {
      isLoading = true;
      skillsList.clear();
      var result = await ApiService.getSkillsListApi();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        skillsList = List<ListDataModel>.from(json['data'].map((i) => ListDataModel.fromJson(i))).toList(growable: true);
      } else {
        errorToast(context, json["status"].toString());
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> getEducationLevelList(BuildContext context) async {
    try {
      isLoading = true;
      educationLevelList.clear();
      var result = await ApiService.getEducationLevelListApi();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        educationLevelList = List<ListDataModel>.from(json['data'].map((i) => ListDataModel.fromJson(i))).toList(growable: true);
      } else {
        errorToast(context, json["status"].toString());
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> getLanguageLevelList(BuildContext context) async {
    try {
      isLoading = true;
      languageLevelList.clear();
      var result = await ApiService.getLanguageLevelListApi();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        languageLevelList = List<ListDataModel>.from(json['data'].map((i) => ListDataModel.fromJson(i))).toList(growable: true);
      } else {
        errorToast(context, json["status"].toString());
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    notifyListeners();
  }
}

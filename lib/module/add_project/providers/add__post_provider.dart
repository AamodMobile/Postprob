import 'dart:convert';
import 'dart:io';

import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/add_project/models/cities_model.dart';
import 'package:postprob/module/add_project/models/success_post_job_model.dart';
import 'package:postprob/module/add_project/views/shared_job_view.dart';
import 'package:postprob/module/profile/models/list_data_model.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';

class AddPostProvider extends ChangeNotifier {
  bool isLoading = false;
  var categoryList = <ListDataModel>[];
  var employmentType = <ListDataModel>[];
  var cityList = <CitiesModel>[];
  List<ListDataModel> filteredList = [];
  List tags = [];
  List postFiles = [];
  TextEditingController searchQuery = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController position = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController hashTag = TextEditingController();
  String employmentTypeId = "";
  String employmentTypeTittle = "";
  String locationId = "";
  String locationTittle = "";
  String workTypeId = "";
  var successPostModel = SuccessPostJobModel();
  File postImage = File("");

  void reset() {
    categoryList.clear();
    employmentType.clear();
    cityList.clear();
    filteredList.clear();
    tags.clear();
    postFiles.clear();
    searchQuery.text = "";
    title.text = "";
    position.text = "";
    description.text = "";
    hashTag.text = "";
    employmentTypeId = "";
    employmentTypeTittle = "";
    locationId = "";
    locationTittle = "";
    workTypeId = "";
    successPostModel = SuccessPostJobModel();
    postImage = File("");
  }

  void employmentUpdate(String value, String v) {
    employmentTypeId = value;
    employmentTypeTittle = v;
    notifyListeners();
  }

  void locationUpdate(String value, String v) {
    locationId = value;
    locationTittle = v;
    notifyListeners();
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      filteredList = categoryList;
    } else {
      List<ListDataModel> tempList = [];
      for (var item in categoryList) {
        if (item.title!.toLowerCase().contains(query.toLowerCase())) {
          tempList.add(item);
        }
      }
      filteredList = tempList;
    }
    notifyListeners();
  }

  Future<void> getCategoryList(BuildContext context) async {
    try {
      isLoading = true;
      categoryList.clear();
      var result = await ApiService.getCategoryListApi();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        categoryList = List<ListDataModel>.from(json['data'].map((i) => ListDataModel.fromJson(i))).toList(growable: true);
      } else {
        if (context.mounted) {
          errorToast(context, json["status"].toString());
        }
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> getEmploymentType(BuildContext context) async {
    try {
      employmentType.clear();
      var result = await ApiService.employmentType();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        employmentType = List<ListDataModel>.from(json['data'].map((i) => ListDataModel.fromJson(i))).toList(growable: true);
      } else {
        if (context.mounted) {
          errorToast(context, json["status"].toString());
        }
      }
    } catch (e) {
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> getCities(BuildContext context) async {
    try {
      cityList.clear();
      var result = await ApiService.cities();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        cityList = List<CitiesModel>.from(json['data'].map((i) => CitiesModel.fromJson(i))).toList(growable: true);
      } else {
        if (context.mounted) {
          errorToast(context, json["status"].toString());
        }
      }
    } catch (e) {
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> createPostProblem(BuildContext context, String categoryId) async {
    try {
      postFiles.add(postImage);
      showProgress(context);
      var result = await ApiService.postCreate(
        title.text,
        categoryId,
        // workTypeId,
        locationId,
        description.text,
        employmentTypeId,
        position.text,
        tags,
        postFiles,
      );
      if (context.mounted) {
        if (result["status"] == true) {
          closeProgress(context);
          successPostModel = SuccessPostJobModel.fromJson(result["data"]);
          Navigator.pushAndRemoveUntil(context, createRightToLeftRoute(const SharedJobView()), (route) => false);
          successToast(context, result["message"].toString());
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
  }
}

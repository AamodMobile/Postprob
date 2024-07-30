import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/profile/models/level_list_model.dart';
import 'package:postprob/module/profile/models/list_data_model.dart';
import 'package:postprob/module/profile/models/profile_model.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';

class ProfileProvider extends ChangeNotifier {
  bool isLoading = false;
  var categoryList = <ListDataModel>[];
  var languageList = <ListDataModel>[];
  var workplaceList = <ListDataModel>[];
  var skillsList = <ListDataModel>[];
  var educationLevelList = <ListDataModel>[];
  var languageLevelList = <LevelListModel>[];
  TextEditingController jobTittle = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController jobDescription = TextEditingController();
  TextEditingController institutionName = TextEditingController();
  TextEditingController fieldOfStudy = TextEditingController();
  TextEditingController startDateStudy = TextEditingController();
  TextEditingController endDateStudy = TextEditingController();
  TextEditingController educationDescription = TextEditingController();
  TextEditingController about = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  var selectedLanguage;
  LevelListModel selectedOralLevelLanguage = LevelListModel();
  LevelListModel selectedWrittenLevelLanguage = LevelListModel();
  TextEditingController searchLanguage = TextEditingController();
  bool isPrimaryLanguage = true;
  ProfileModel profileModel = ProfileModel();
  String? selectedFilePath;
  int? fileSize;
  DateTime? fileDate;

  Future<void> uploadPDFFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      selectedFilePath = result.files.single.path;
      fileSize = File(selectedFilePath!).lengthSync();
      fileDate = File(selectedFilePath!).lastModifiedSync();
    } else {
      errorToast(context, "File Not Picked");
    }
    notifyListeners();
  }

  void removeSelectedFile() {
    selectedFilePath = null;
    fileSize = null;
    fileDate = null;
    notifyListeners();
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy \'at\' hh:mm a').format(dateTime);
  }

  void setSearchLanguage(String search) {
    searchLanguage.text = search;
    notifyListeners();
  }

  void isPrimaryLanguageSet(bool isPrimary) {
    isPrimaryLanguage = isPrimary;
    notifyListeners();
  }

  void setSelectedLanguage(var selectLanguage) {
    selectedLanguage = selectLanguage;
    notifyListeners();
  }

  void setSelectedOralLevelLanguage(var selectOral) {
    selectedOralLevelLanguage = selectOral;
    notifyListeners();
  }

  void setSelectedWrittenLevelLanguage(var selectWritten) {
    selectedWrittenLevelLanguage = selectWritten;
    notifyListeners();
  }

  void reset() {
    jobTittle.text = "";
    companyName.text = "";
    startDate.text = "";
    endDate.text = "";
    jobDescription.text = "";
    institutionName.text = "";
    fieldOfStudy.text = "";
    startDateStudy.text = "";
    endDateStudy.text = "";
    educationDescription.text = "";
    about.text = "";
    selectedOralLevelLanguage = LevelListModel(id: 0, title: "", slug: "");
    selectedWrittenLevelLanguage = LevelListModel(id: 0, title: "", slug: "");
    searchLanguage.text = "";
    isPrimaryLanguage = false;
  }

  void reset1() {
    selectedLanguage = null;
  }

  void setStartDate(DateTime date, String type) {
    _startDate = date;
    if (type == "work experience") {
      startDate.text = _formatDate(date);
    } else if (type == "Education") {
      startDateStudy.text = _formatDate(date);
    }

    notifyListeners();
  }

  void setEndDate(DateTime date, String type) {
    _endDate = date;
    if (type == "work experience") {
      endDate.text = _formatDate(date);
    } else if (type == "Education") {
      endDateStudy.text = _formatDate(date);
    }

    notifyListeners();
  }

  void openDatePicker(BuildContext context, bool isStartDate, String type) async {
    final initialDate = isStartDate ? _startDate ?? DateTime.now() : _endDate ?? DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      if (context.mounted) {
        if (type == "work experience") {
          if (isStartDate) {
            setStartDate(pickedDate, type);
          } else {
            if (_startDate != null && pickedDate.isBefore(_startDate!)) {
              errorToast(context, "End date cannot be before start date");
            } else {
              setEndDate(pickedDate, type);
            }
          }
        } else if (type == "Education") {
          if (isStartDate) {
            setStartDate(pickedDate, type);
          } else {
            if (_startDate != null && pickedDate.isBefore(_startDate!)) {
              errorToast(context, "End date cannot be before start date");
            } else {
              setEndDate(pickedDate, type);
            }
          }
        }
      }
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString()}";
  }

  Future<void> getLanguageList(BuildContext context, String search) async {
    try {
      isLoading = true;
      languageList.clear();
      var result = await ApiService.getLanguageListApi(search);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        languageList = List<ListDataModel>.from(json['data'].map((i) => ListDataModel.fromJson(i))).toList(growable: true);
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

  Future<void> getWorkplaceList(BuildContext context) async {
    try {
      isLoading = true;
      workplaceList.clear();
      var result = await ApiService.getWorkplaceListApi();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        workplaceList = List<ListDataModel>.from(json['data'].map((i) => ListDataModel.fromJson(i))).toList(growable: true);
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

  Future<void> getSkillsList(BuildContext context) async {
    try {
      isLoading = true;
      skillsList.clear();
      var result = await ApiService.getSkillsListApi();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        skillsList = List<ListDataModel>.from(json['data'].map((i) => ListDataModel.fromJson(i))).toList(growable: true);
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

  Future<void> getEducationLevelList(BuildContext context) async {
    try {
      isLoading = true;
      educationLevelList.clear();
      var result = await ApiService.getEducationLevelListApi();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        educationLevelList = List<ListDataModel>.from(json['data'].map((i) => ListDataModel.fromJson(i))).toList(growable: true);
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

  Future<void> getLanguageLevelList(BuildContext context) async {
    try {
      isLoading = true;
      languageLevelList.clear();
      var result = await ApiService.getLanguageLevelListApi();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        languageLevelList = List<LevelListModel>.from(json['data'].map((i) => LevelListModel.fromJson(i))).toList(growable: true);
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

  Future<void> addUserExperienceApi(
    BuildContext context,
    String userExperienceId,
    String title,
    String company,
    String startDate,
    String endDate,
    String description,
  ) async {
    try {
      showProgress(context);
      var result = await ApiService.addUserExperienceApi(userExperienceId, title, company, startDate, endDate, description);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          await userGetProfile(context);
          if (context.mounted) {
            Navigator.pop(context);
            successToast(context, json["message"].toString());
          }
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
    notifyListeners();
  }

  Future<void> addUserEducationApi(
    BuildContext context,
    String userEducationId,
    String educationLavelId,
    String institutionName,
    String fieldOfStudy,
    String startDate,
    String endDate,
    String description,
  ) async {
    try {
      showProgress(context);
      var result = await ApiService.addUserEducationApi(userEducationId, educationLavelId, institutionName, fieldOfStudy, startDate, endDate, description);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          await userGetProfile(context);
          if (context.mounted) {
            Navigator.pop(context);
            successToast(context, json["message"].toString());
          }
        } else {
          closeProgress(context);
          errorToast(context, json["message"].toString());
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

  Future<void> addUserDocumentsApi(
    BuildContext context,
    String userDocumentId,
    String title,
    String document,
  ) async {
    try {
      showProgress(context);
      var result = await ApiService.addUserDocumentsApi(userDocumentId, title, document);
      if (context.mounted) {
        if (result["status"] == true) {
          closeProgress(context);
          await userGetProfile(context);
          if (context.mounted) {
            removeSelectedFile();
            successToast(context, result["message"].toString());
          }
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

  Future<void> addUserLanguage(
    BuildContext context,
    String userLanguageId,
    String languageId,
    String oralLavel,
    String writtenLavel,
    String isPrimary,
  ) async {
    try {
      showProgress(context);
      var result = await ApiService.addUserLanguage(userLanguageId, languageId, oralLavel, writtenLavel, isPrimary);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          await userGetProfile(context);
          if (context.mounted) {
            Navigator.pop(context);
            Navigator.pop(context);
            successToast(context, json["message"].toString());
          }
        } else {
          closeProgress(context);
          errorToast(context, json["message"].toString());
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

  Future<void> addAbout(BuildContext context, String about) async {
    try {
      showProgress(context);
      var result = await ApiService.aboutMe(about);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          await userGetProfile(context);
          if (context.mounted) {
            Navigator.pop(context);
            successToast(context, json["message"].toString());
          }
        } else {
          closeProgress(context);
          errorToast(context, json["message"].toString());
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

  Future<void> skillsAdd(
    BuildContext context,
    var selectedSkillsList,
  ) async {
    try {
      showProgress(context);
      var result = await ApiService.skillsAdd(selectedSkillsList);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          await userGetProfile(context);
          if (context.mounted) {
            Navigator.pop(context);
            successToast(context, json["message"].toString());
          }
        } else {
          closeProgress(context);
          errorToast(context, json["message"].toString());
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

  Future<void> deleteUserDocument(BuildContext context, String userDocumentId) async {
    try {
      showProgress(context);
      var result = await ApiService.deleteUserDocument(userDocumentId);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          await userGetProfile(context);
          if (context.mounted) {
            successToast(context, json["message"].toString());
          }
        } else {
          closeProgress(context);
          errorToast(context, json["message"].toString());
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

  Future<void> deleteUserLanguage(BuildContext context, String userLanguageId) async {
    try {
      showProgress(context);
      var result = await ApiService.deleteUserLanguage(userLanguageId);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          await userGetProfile(context);
          if (context.mounted) {
            Navigator.pop(context);
            successToast(context, json["message"].toString());
          }
        } else {
          closeProgress(context);
          errorToast(context, json["message"].toString());
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
}

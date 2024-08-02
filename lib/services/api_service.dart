// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:postprob/module/login/model/user_model.dart';
import 'package:postprob/services/api_client.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static var client = http.Client();

  ///loginApi
  static Future<http.Response> loginApi(
    String email,
    String password,
  ) async {
    http.Response response;
    var result = await ApiClient.postData(ApiUrl.login, body: {
      'email': email,
      'password': password,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  ///registerApi
  static Future<http.Response> register(
    String name,
    String email,
    String password,
    String state,
    String city,
    String cityId,
  ) async {
    http.Response response;
    var result = await ApiClient.postData(ApiUrl.register, body: {
      'name': name,
      'email': email,
      'password': password,
      'state': state,
      'city': city,
      'city_id': cityId,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  ///getHomeDataApi
  static Future<http.Response> getHomeDataApi() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.home, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> getCategoryListApi() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.category, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> getLanguageListApi(String search) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.language, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "search_title": search
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> getWorkplaceListApi() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.workplace, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> getEducationLevelListApi() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.educationLevel, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> getLanguageLevelListApi() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.languageLevel, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> getSkillsListApi() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.skills, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> addUserExperienceApi(
    String userExperienceId,
    String title,
    String company,
    String startDate,
    String endDate,
    String description,
    String isPosition,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.addUserExperience, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "user_experience_id": userExperienceId,
      "title": title,
      "company": company,
      "start_date": startDate,
      "end_date": endDate,
      "description": description,
      "is_position": isPosition,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> addUserEducationApi(
    String userEducationId,
    String educationLevelId,
    String institutionName,
    String fieldOfStudy,
    String startDate,
    String endDate,
    String description,
    String isPosition,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.addUserEducation, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "user_education_id": userEducationId,
      "education_lavel_id": educationLevelId,
      "institution_name": institutionName,
      "field_of_study": fieldOfStudy,
      "start_date": startDate,
      "end_date": endDate,
      "description": description,
      "is_position": isPosition,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<dynamic> addUserDocumentsApi(
    String userDocumentId,
    String title,
    String document,
  ) async {
    var result;
    http.Response response;
    try {
      var url = ApiUrl.addUserDocuments;
      Log.console('Http.Post Url: $url');
      var instance = await SharedPreferences.getInstance();
      var token = instance.getString('currentToken');
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      Log.console('Http.Post Headers: ${request.headers}');
      request.fields['user_document_id'] = userDocumentId;
      request.fields['title'] = title;
      if (document.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('document', document);
        request.files.add(file);
      }
      Log.console('Http.Post filed: ${request.fields}');
      response = await http.Response.fromStream(await request.send());
      Log.console('Http.Response Body: ${response.body}');
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        result = {'status_code': 400, 'message': '404'};
      } else if (response.statusCode == 401) {
        result = jsonDecode(response.body);
      }
    } catch (e) {
      result = http.Response(
        jsonEncode({e.toString()}),
        204,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }
    return result;
  }

  static Future<http.Response> addUserLanguage(
    String userLanguageId,
    String languageId,
    String oralLevel,
    String writtenLevel,
    String isPrimary,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.addUserLanguage, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "user_language_id": userLanguageId,
      "language_id": languageId,
      "oral_lavel": oralLevel,
      "written_lavel": writtenLevel,
      "is_primary": isPrimary
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> logout() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.logout, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> aboutMe(String aboutMe) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.profileUpdate, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "about_me": aboutMe,
      "name": crtUser.dataUser?.name.toString(),
      "email": crtUser.dataUser?.email.toString(),
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> skillsAdd(var skills) async {
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    if (crtData == null) {
      throw Exception('Current user data not found');
    }
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData));
    final body = jsonEncode({
      'skills': skills,
      "email": crtUser.dataUser?.email.toString(),
    });
    var url = Uri.parse(ApiUrl.profileUpdate);
    var result = await http.post(url,
        headers: {
          'Authorization': 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
        body: body);
    return result;
  }

  static Future<http.Response> profileUpdate(
    String name,
    String email,
    String mobile,
    String gender,
    String dob,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var crtData = instance.getString('currentUser');
    UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
    var result = await ApiClient.postData(ApiUrl.profileUpdate, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "name": name,
      "email": crtUser.dataUser?.email.toString(),
      "mobile": mobile,
      "gender": gender,
      "dob": dob,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<dynamic> profileImage(String profileImage) async {
    var result;
    http.Response response;
    try {
      var url = ApiUrl.profileUpdate;
      Log.console('Http.Post Url: $url');
      var instance = await SharedPreferences.getInstance();
      var token = instance.getString('currentToken');
      var crtData = instance.getString('currentUser');
      UserModel crtUser = UserModel.fromJson(jsonDecode(crtData!));
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      Log.console('Http.Post Headers: ${request.headers}');
      request.fields['email'] = crtUser.dataUser!.email.toString();
      if (profileImage.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('profile_image', profileImage);
        request.files.add(file);
      }
      Log.console('Http.Post filed: ${request.fields}');
      response = await http.Response.fromStream(await request.send());
      Log.console('Http.Response Body: ${response.body}');
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        result = {'status_code': 400, 'message': '404'};
      } else if (response.statusCode == 401) {
        result = jsonDecode(response.body);
      }
    } catch (e) {
      result = http.Response(
        jsonEncode({e.toString()}),
        204,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }
    return result;
  }

  static Future<http.Response> changePassword(
    String password,
    String newPassword,
    String confirmPassword,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.changePassword, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "password": password,
      "new_password": newPassword,
      "confirm_password": confirmPassword,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> manageNotification(String isOn) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.manageNotification, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "is_on": isOn,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> deleteUserDocument(String userDocumentId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.deleteUserDocument, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "user_document_id": userDocumentId,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> deleteUserLanguage(String userLanguageId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.deleteUserLanguage, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "user_language_id": userLanguageId,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> userGetProfile() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.userGetProfile, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> postListGet() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.postList, headers: {
      'Authorization': 'Bearer $token',
    }, body: {});
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> postDetailGet(String postId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.postDetail,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "post_id": postId,
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<dynamic> jobApply(String postId, String resume, String info) async {
    var result;
    http.Response response;
    try {
      var url = ApiUrl.jobApply;
      Log.console('Http.Post Url: $url');
      var instance = await SharedPreferences.getInstance();
      var token = instance.getString('currentToken');
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      Log.console('Http.Post Headers: ${request.headers}');
      request.fields['job_id'] = postId;
      request.fields['info '] = info;
      if (resume.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('resume', resume);
        request.files.add(file);
      }
      Log.console('Http.Post filed: ${request.fields}');
      response = await http.Response.fromStream(await request.send());
      Log.console('Http.Response Body: ${response.body}');
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        result = {'status_code': 400, 'message': '404'};
      } else if (response.statusCode == 401) {
        result = jsonDecode(response.body);
      }
    } catch (e) {
      result = http.Response(
        jsonEncode({e.toString()}),
        204,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }
    return result;
  }

  static Future<http.Response> savePost(String postId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.savePost,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "post_id": postId,
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> removeSavedPost(String postId, String type) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.removeSavedPost,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "post_id": postId,
        "type": type,
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> savedPostsList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.savedPostsList,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {},
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> employmentType() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.employmentType,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {},
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<dynamic> postCreate(
    String title,
    String category,
    // String workplace,
    String location,
    String description,
    String employmentType,
    String position,
    String address,
    var tags,
    var postFiles,
  ) async {
    var result;
    http.Response response;
    try {
      var url = ApiUrl.postCreate;
      Log.console('Http.Post Url: $url');
      var instance = await SharedPreferences.getInstance();
      var token = instance.getString('currentToken');
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      Log.console('Http.Post Headers: ${request.headers}');
      request.fields['title'] = title;
      request.fields['category'] = category;
      request.fields['workplace'] = "1";
      request.fields['location'] = location;
      request.fields['description'] = description;
      request.fields['employment_type'] = employmentType;
      request.fields['position'] = position;
      request.fields['address'] = address;
      if (postFiles.isNotEmpty) {
        for (int i = 0; i < postFiles.length; i++) {
          final File file = File(postFiles[i].path);
          http.MultipartFile file2 = await http.MultipartFile.fromPath("post_files[$i]", file.path.toString());
          request.files.add(file2);
        }
      }
      if (tags.isNotEmpty) {
        for (int i = 0; i < tags.length; i++) {
          request.fields['tags[$i]'] = tags[i];
        }
      }
      Log.console('Http.Post filed: ${request.fields}');
      response = await http.Response.fromStream(await request.send());
      Log.console('Http.Response Body: ${response.body}');
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        result = {'status_code': 400, 'message': '404'};
      } else if (response.statusCode == 401) {
        result = jsonDecode(response.body);
      }
    } catch (e) {
      result = http.Response(
        jsonEncode({e.toString()}),
        204,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }
    return result;
  }

  static Future<http.Response> cities() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.cities,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {},
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> appliedJobsList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.appliedJobsList,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {},
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> appliedJobDetail(String appliedJobId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.appliedJobDetail,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "applied_job_id": appliedJobId,
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> myPosts() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.myPosts,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {},
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> forgetPassword(String email) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.forgetPassword,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {"email": email},
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> chatList() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.chatList,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {},
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> myPostDetail(String postId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      ApiUrl.myPostDetail,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {"post_id": postId},
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<http.Response> getMessages(String recipientId, String pageId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(
      "${ApiUrl.getMessages}?page=$pageId",
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "recipient_id": recipientId,
      },
    );
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }

  static Future<dynamic> sendMessage(
    String message,
    String recipientId,
    String eventId,
    String channelId,
    var files,
    var video,
    var photos,
  ) async {
    var result;
    http.Response response;
    try {
      var url = ApiUrl.sendMessage;
      Log.console('Http.Post Url: $url');
      var instance = await SharedPreferences.getInstance();
      var token = instance.getString('currentToken');
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      Log.console('Http.Post Headers: ${request.headers}');
      request.fields['message'] = message;
      request.fields['recipient_id'] = recipientId;
      request.fields['workplace'] = "1";
      request.fields['event_id'] = eventId;
      request.fields['channel_id'] = channelId;
      if (files.isNotEmpty) {
        for (int i = 0; i < files.length; i++) {
          final File file = File(files[i].path);
          http.MultipartFile file2 = await http.MultipartFile.fromPath("files[$i]", file.path.toString());
          request.files.add(file2);
        }
      }
      if (photos.isNotEmpty) {
        for (int i = 0; i < photos.length; i++) {
          final File file = File(photos[i].path);
          http.MultipartFile file2 = await http.MultipartFile.fromPath("photos[$i]", file.path.toString());
          request.files.add(file2);
        }
      }
      if (video.isNotEmpty) {
        for (int i = 0; i < video.length; i++) {
          final File file = File(video[i].path);
          http.MultipartFile file2 = await http.MultipartFile.fromPath("videos[$i]", file.path.toString());
          request.files.add(file2);
        }
      }
      Log.console('Http.Post filed: ${request.fields}');
      response = await http.Response.fromStream(await request.send());
      Log.console('Http.Response Body: ${response.body}');
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        result = {'status_code': 400, 'message': '404'};
      } else if (response.statusCode == 401) {
        result = jsonDecode(response.body);
      }
    } catch (e) {
      result = http.Response(
        jsonEncode({e.toString()}),
        204,
        headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      );
    }
    return result;
  }

  static Future<http.Response> updateFcmToken(String fcmToken) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.fcmTokenUpdate, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "device_key": fcmToken,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> clearAllMessages(String eventId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.clearAllMessages, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "event_id": eventId,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> readAllMessages(String eventId) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.readAllMessages, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "event_id": eventId,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> muteChat(
    String channelId,
    String recipientId,
    String isMute,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.muteChat, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "channel_id": channelId,
      "recipient_id": recipientId,
      "is_mute": isMute,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }

  static Future<http.Response> blockChat(
    String channelId,
    String recipientId,
    String isBlock,
  ) async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.blockChat, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "channel_id": channelId,
      "recipient_id": recipientId,
      "is_block": isBlock,
    });
    response = http.Response(
      jsonEncode(result),
      200,
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
    );
    return response;
  }
}

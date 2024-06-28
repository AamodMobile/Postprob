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
  ) async {
    http.Response response;
    var result = await ApiClient.postData(ApiUrl.register, body: {
      'name': name,
      'email': email,
      'password': password,
    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }
  static Future<http.Response> getHomeDataApi() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.home, headers: {
      'Authorization': 'Bearer $token',
    }, body: {

    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }
  ///profileApi
  static Future<dynamic> profileApi(
    String aadharNo,
    String panNo,
    String medicalRegistrationNo,
    String educationNo,
    String aadharCardFront,
    String aadharCardBack,
    String panCard,
    String medicalRegistrationDoc,
    String educationDoc,
    String name,
    String mobile,
    String password,
    String businessName,
    String alternateMobile,
    String deviceKey,
    String experience,
    String addressLine,
    String pincode,
    String state,
    String city,
    String aboutVendor,
    String email,
  ) async {
    var result;
    http.Response response;
    try {
      var url = ApiUrl.register;
      Log.console('Http.Post Url: $url');
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
      Log.console('Http.Post Headers: ${request.headers}');
      request.fields['aadhar_no'] = aadharNo.trim();
      request.fields['pan_no'] = panNo;
      request.fields['medical_registration_no'] = medicalRegistrationNo;
      request.fields['education_no'] = educationNo;
      request.fields['name'] = name.trim();
      request.fields['mobile_no'] = mobile.trim();
      request.fields['password'] = password;
      request.fields['business_name'] = businessName;
      request.fields['alternate_mobile'] = alternateMobile;
      request.fields['device_key'] = deviceKey;
      request.fields['experience'] = experience;
      request.fields['address_line_1'] = addressLine;
      request.fields['pincode'] = pincode;
      request.fields['state'] = state;
      request.fields['city'] = city;
      request.fields['about_vendor'] = aboutVendor;
      request.fields['email'] = email;
      if (aadharCardFront.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('aadhar_card_front', aadharCardFront);
        request.files.add(file);
      }
      if (aadharCardBack.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('aadhar_card_back', aadharCardBack);
        request.files.add(file);
      }
      if (panCard.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('pan_card', panCard);
        request.files.add(file);
      }
      if (medicalRegistrationDoc.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('medical_registration_doc', medicalRegistrationDoc);
        request.files.add(file);
      }
      if (educationDoc.isNotEmpty) {
        http.MultipartFile file = await http.MultipartFile.fromPath('education_doc', educationDoc);
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

  static Future<http.Response> getCategoryListApi() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.category, headers: {
      'Authorization': 'Bearer $token',
    }, body: {

    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }
  static Future<http.Response> getLanguageListApi() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.language, headers: {
      'Authorization': 'Bearer $token',
    }, body: {

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
    }, body: {

    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }
  static Future<http.Response> getEducationLevelListApi() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.educationLevel, headers: {
      'Authorization': 'Bearer $token',
    }, body: {

    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }
  static Future<http.Response> getLanguageLevelListApi() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.languageLevel, headers: {
      'Authorization': 'Bearer $token',
    }, body: {

    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }
  static Future<http.Response> getSkillsListApi() async {
    http.Response response;
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('currentToken');
    var result = await ApiClient.postData(ApiUrl.skills, headers: {
      'Authorization': 'Bearer $token',
    }, body: {

    });
    response = http.Response(jsonEncode(result), 200, headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
    return response;
  }
}

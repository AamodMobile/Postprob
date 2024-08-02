// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/add_project/models/cities_model.dart';
import 'package:postprob/module/dashboard/view/dashboard_view.dart';
import 'package:postprob/module/login/model/user_model.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpProvider extends ChangeNotifier {
  String mobileNo = "";
  String passwordV = "";
  String nameV = "";
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? currentAddress;
  Position? _currentPosition;
  var pincode = "";
  var city = "";
  var cityId = "";
  var state = "";
  var cityModel;
  var cityList = <CitiesModel>[];
  bool isHide = true;

  void reset() {
    password.clear();
    emailController.clear();
    name.clear();
    passwordV = "";
    mobileNo = "";
    nameV = "";
    cityId = "";
    cityModel = null;
  }

  void cityUpdate(CitiesModel citiesModel, String id) {
    cityModel = citiesModel;
    cityId = id;
    notifyListeners();
  }

  void emailUpdate(String email) {
    emailController.text = email;
    notifyListeners();
  }

  void passwordUpdate(String passwordT) {
    password.text = passwordT;
    notifyListeners();
  }

  void nameUpdate(String nameT) {
    name.text = nameT;
    notifyListeners();
  }

  void isShow(bool show) {
    isHide = show;
    notifyListeners();
  }

  String? emailValidator(value) {
    const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    final regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Enter an email';
    } else if (!regExp.hasMatch(
      value.toString().trim(),
    )) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  Future<void> getCities(BuildContext context) async {
    try {
      cityModel = null;
      cityList.clear();
      var result = await ApiService.cities();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        cityList = List<CitiesModel>.from(json['data'].map((i) => CitiesModel.fromJson(i))).toList(growable: true);
      } else {
        if (context.mounted) {
          //errorToast(context, json["status"].toString());
        }
      }
    } catch (e) {
      Log.console(e.toString());
    }
    notifyListeners();
  }

  Future<void> registerApiCall(BuildContext context, String state, String city) async {
    try {
      showProgress(context);
      var result = await ApiService.register(name.text, emailController.text, password.text, state, city, cityId);
      var json = jsonDecode(result.body);
      final apiResponse = UserModel.fromJson(json);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          reset();
          var pref = await SharedPreferences.getInstance();
          await pref.setString('currentUser', jsonEncode(apiResponse.toJson()));
          await pref.setString('currentToken', apiResponse.accessToken.toString());
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashboardView(index: 0)), (route) => false);
            successToast(context, json["message"]);
          }
        } else {
          closeProgress(context);
          errorToast(context, json["message"]);
        }
      }
    } catch (e) {
      if (context.mounted) {
        closeProgress(context);
        Log.console(e.toString());
      }
    }
  }

  Future<void> getCheckInStatus(BuildContext context) async {
    try {
      final position = await LocationStatus().determinePosition(context);
      if (position.latitude != 0.0 && position.longitude != 0.0) {
        await getCurrentPosition();
      } else {
        if (context.mounted) {
          errorToast(context, 'Location is not detected. Please check if location is enabled and try again.');
        }
      }
    } catch (e) {
      Log.console(e.toString());
    }
  }

  Future<void> getCurrentPosition() async {
    try {
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
        _currentPosition = position;
        _getAddressFromLatLng(_currentPosition!);
      }).catchError((e) {
        debugPrint("$e");
      });
    } catch (e) {
      Log.console(e.toString());
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      await placemarkFromCoordinates(position.latitude, position.longitude).then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        currentAddress = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
        pincode = '${place.postalCode}';
        city = '${place.locality}';
        state = place.administrativeArea ?? '';
        Log.console(state);
        notifyListeners();
      }).catchError((e) {
        debugPrint(e);
      });
    } catch (e) {
      Log.console(e.toString());
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    Log.console(credential);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class LocationStatus {
  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) {
        _showLocationDialog(context);
      }
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions. Please give permission and try again.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
  }

  void _showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Service Disabled'),
          content: const Text('Please enable your location service.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Settings'),
              onPressed: () async {
                await openAppSettings();
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:postprob/constants/constants.dart';
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

  void reset() {
    password.clear();
    emailController.clear();
    name.clear();
    passwordV = "";
    mobileNo = "";
    nameV = "";
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

  Future<void> registerApiCall(BuildContext context) async {
    try {
      showProgress(context);
      var result = await ApiService.register(name.text, emailController.text, password.text);
      var json = jsonDecode(result.body);
      final apiResponse = UserModel.fromJson(json);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          var pref = await SharedPreferences.getInstance();
          await pref.setString(
            'currentUser',
            jsonEncode(apiResponse.toJson()),
          );
          await pref.setString('currentToken', apiResponse.accessToken.toString());
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                createRightToLeftRoute(const DashboardView(
                  index: 0,
                )),
                (route) => false);
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
      final position = await LocationStatus().determinePosition();
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
        notifyListeners();
      }).catchError((e) {
        debugPrint(e);
      });
    } catch (e) {
      Log.console(e.toString());
    }
  }
}

class LocationStatus {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Please enable your location, it seems to be turned off.');
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
}

import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:postprob/constants/constants.dart';
import 'package:postprob/module/profile/providers/profile_provider.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:postprob/services/api_service.dart';

class EditProfileProvider extends ChangeNotifier {
  DateTime? _dateOfBirth;
  TextEditingController dob = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  String gender = "";
  String image = "";
  String city = "";
  FocusNode phoneF = FocusNode();
  File profileImage = File("");

  void setDob(DateTime date) {
    _dateOfBirth = date;
    dob.text = _formatDate(date);
    notifyListeners();
  }

  void setGender(String genderT) {
    gender = genderT;
    notifyListeners();
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString()}";
  }

  void openDatePicker(BuildContext context) async {
    final initialDate = _dateOfBirth ?? DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setDob(pickedDate);
    }
  }

  Future<void> profileUpdate(
    BuildContext context,
    var name,
    var email,
    var mobile,
    var gender,
    var dob,
  ) async {
    try {
      showProgress(context);
      var result = await ApiService.profileUpdate(name, email, mobile, gender, dob);
      var json = jsonDecode(result.body);
      if (context.mounted) {
        if (json["status"] == true) {
          closeProgress(context);
          Provider.of<ProfileProvider>(context, listen: false).userGetProfile(context);
          Navigator.pop(context);
          successToast(context, json["message"].toString());
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

  Future<ImageSource?> imagePickerSheet(context) async {
    ImageSource? source = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            color: Colors.white,
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_rounded,
                          color: mainColor,
                          size: 40,
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(color: mainColor),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Icon(
                          Icons.photo_rounded,
                          color: mainColor,
                          size: 40,
                        ),
                        Text('Gallery', style: TextStyle(color: mainColor)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
    return source;
  }

  void pickImage(BuildContext context) async {
    var source = await imagePickerSheet(context);
    if (source != null) {
      // ignore: invalid_use_of_visible_for_testing_member
      var picker = ImagePicker.platform;
      // ignore: deprecated_member_use
      var file = await picker.pickImage(
        source: source,
        maxHeight: 1080,
        maxWidth: 1080,
        imageQuality: 90,
      );
      profileImage = File(file!.path);
      if (profileImage.path != "") {
        if (context.mounted) {
          profileImageUpdate(context, profileImage.path);
        }
      }
    }
  }

  Future<void> profileImageUpdate(
    BuildContext context,
    var profileImage,
  ) async {
    try {
      showProgress(context);
      var result = await ApiService.profileImage(profileImage);
      if (context.mounted) {
        if (result["status"] == true) {
          closeProgress(context);
          Provider.of<ProfileProvider>(context, listen: false).userGetProfile(context);
          Navigator.pop(context);
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
    notifyListeners();
  }
}

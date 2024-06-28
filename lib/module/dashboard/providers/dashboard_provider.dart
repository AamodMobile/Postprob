import 'dart:convert';

import 'package:postprob/constants/constants.dart';
import 'package:postprob/core/utils/local_storage.dart';
import 'package:postprob/module/add_project/views/add_project_view.dart';
import 'package:postprob/module/chat/views/chat_view.dart';
import 'package:postprob/module/connection/views/connection_view.dart';
import 'package:postprob/module/dashboard/widgets/exit_bottom_sheet.dart';
import 'package:postprob/module/home/view/home_view.dart';
import 'package:postprob/module/login/model/user_model.dart';
import 'package:postprob/module/save/views/save_view.dart';
import 'package:postprob/services/api_logs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardProvider extends ChangeNotifier {
  UserModel? userModel;
  UserModel? _crtUser;

  UserModel? get crtUser => _crtUser;
  String? userName = "";
  List<String> baseIcons = [
    homeIc,
    connectionIc,
    chatIc,
    chatIc,
    saveIc,
  ];

  List<Widget> baseWidgets = [
    const HomeView(),
    const ConnectionView(),
    const AddProjectView(),
    const ChatView(),
    const SaveView(),
  ];

  void reset() {
    // indexStack = [0];
  }

  List<int> indexStack = [0];

  int get baseActiveBottomIndex => indexStack.last;

  void onChangeBaseBottomIndex(int index) {
    if (index != baseActiveBottomIndex) {
      indexStack.add(index);
      notifyListeners();
    }
  }

  Future<void> initApp({required BuildContext context}) async {
    try {
      var instance = await SharedPreferences.getInstance();
      var crtData = instance.getString('currentUser');

      if (crtData != null) {
        _crtUser = UserModel.fromJson(jsonDecode(crtData));
        notifyListeners();
      }

      userName = await LocalStorage.getUserName();
      var profilePic = await LocalStorage.getUserProfile();
    } catch (e) {
      Log.console('Error initializing app: $e');
    }
    notifyListeners();
  }

  bool onWillPop(BuildContext context) {
    /*
   for one by one back
   if (indexStack.length > 1) {
      indexStack.removeLast();
    } else {*/
    if (indexStack.last != 0) {
      indexStack = [0];
    } else {
      ExitSheet.show(context);
      //return true;
    }
    //}
    notifyListeners();
    return false;
  }

  void navigateToFirstIndex(int index) {
    if (indexStack.isNotEmpty && indexStack.last != index) {
      indexStack = [index];
      notifyListeners();
    }
  }
}

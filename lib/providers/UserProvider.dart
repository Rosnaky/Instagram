import "package:flutter/material.dart";
import "package:instagram_flutter/models/user.dart";
import "package:instagram_flutter/resources/AuthMethods.dart";
import "package:instagram_flutter/models/user.dart" as userModel;

class UserProvider with ChangeNotifier {
  userModel.User? _user;
  final AuthMethods _authMethods = AuthMethods();

  userModel.User get getUser => _user!;

  Future<void> refreshUser() async {
    userModel.User user = await _authMethods.getUserDetails();
    _user = user;

    notifyListeners();
  }
}

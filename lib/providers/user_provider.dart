import 'package:dog_app/entities/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  @override
  notifyListeners();

  void createUser(String name, String email, String type, String phoneNumber,
      String location) {
    _user = User(name, email, type, phoneNumber, location);
  }

  // void signOut() {
  //   _user = null;
  // }
}

import 'package:dog_app/entities/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  void createUser(String name, String email, String type) {
    _user = User(name, email, type);
  }
}

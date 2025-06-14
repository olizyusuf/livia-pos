import 'package:flutter/material.dart';
import 'package:liviapos/model/user.dart';

class UserProvider with ChangeNotifier {
  User? _initUser;

  TextEditingController cUsername = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cRePassword = TextEditingController();

  void initEditUser(User user) {
    _initUser = user;
    cUsername.text = user.username;
    cPassword.text = user.password;
    cRePassword.text = user.password;
  }

  void initAddUser() {
    _initUser = null;
    cUsername.text = '';
    cPassword.text = '';
    cRePassword.text = '';
  }

  //getter
  User? get initUser => _initUser;
}

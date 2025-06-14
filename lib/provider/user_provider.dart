import 'package:flutter/material.dart';
import 'package:liviapos/model/user.dart';

class UserProvider extends ChangeNotifier {
  User? _initUser;
  String _role = 'Administrator';

  TextEditingController cUsername = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cRePassword = TextEditingController();

  List<String> roles = [];

  void initEditUser(User user) {
    getRoles();
    _initUser = user;
    cUsername.text = user.username;
    cPassword.text = user.password;
    cRePassword.text = user.password;
    _role = user.role;
  }

  void initAddUser() {
    getRoles();
    _initUser = null;
    cUsername.text = '';
    cPassword.text = '';
    cRePassword.text = '';
    _role = 'Administrator';
  }

  void getRoles() {
    roles = ['Administrator', 'Kasir'];
  }

  //getter
  User? get initUser => _initUser;
  String get role => _role;

  //setter
  set role(String value) {
    _role = value;
    notifyListeners();
  }
}

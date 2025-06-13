import 'package:flutter/material.dart';
import 'package:liviapos/model/user.dart';

class UserProvider with ChangeNotifier {
  User? _initUser;
  String _username = '';
  String _password = '';
  String _role = '';

  void initEditUser(User user) {
    _initUser = user;
    _username = user.username;
    _password = user.password;
    _role = user.role;
    notifyListeners();
  }

  void initAddUser() {
    _initUser = null;
    _username = '';
    _password = '';
    _role = '';
    notifyListeners();
  }

  //getter
  User? get initUser => _initUser;
  String get username => _username;
  String get password => _password;
  String get role => _role;

  //setter
  set username(val) {
    _username = val;
    notifyListeners();
  }

  set password(val) {
    _password = val;
    notifyListeners();
  }

  set role(val) {
    _role = val;
    notifyListeners();
  }
}

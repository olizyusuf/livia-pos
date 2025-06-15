import 'package:flutter/material.dart';
import 'package:liviapos/model/role.dart';
import 'package:liviapos/model/user.dart';

class UserProvider extends ChangeNotifier {
  User? _initUser;
  Role? _initRole;
  String _role = 'Administrator';
  String _namaRole = '';
  String _permission = '';

  TextEditingController cUsername = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cRePassword = TextEditingController();

  TextEditingController cNamaRole = TextEditingController();

  List<String> roles = [];

  List<String> menus = [
    "Penjualan",
    "Pembelian",
    "Master",
    "Laporan",
    "Users",
    "Printer",
    "Database",
    "Setting"
  ];

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
    roles = ['Administrator', 'Kasir', 'Admin'];
  }

  void initEditRole(Role role) {
    _initRole = role;
    _namaRole = role.nama;
    cNamaRole.text = role.nama;
    _permission = role.permission;
  }

  void initAddRole() {
    _initRole = null;
  }

  //getter
  User? get initUser => _initUser;
  Role? get initRole => _initRole;
  String get role => _role;
  String get namaRole => _namaRole;
  String get permission => _permission;

  //setter
  set role(String value) {
    _role = value;
    notifyListeners();
  }

  set namaRole(String value) {
    _namaRole = value;
    notifyListeners();
  }

  set permission(String value) {
    _permission = value;
    notifyListeners();
  }
}

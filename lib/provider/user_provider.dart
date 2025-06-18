import 'package:flutter/material.dart';
import 'package:liviapos/model/role.dart';
import 'package:liviapos/model/user.dart';

import '../databases/db_helper.dart';

class UserProvider extends ChangeNotifier {
  User? _initUser;
  Role? _initRole;
  String _role = 'Administrator';
  String _namaRole = '';
  List<String> _permission = [];
  String _title = '';

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

  final DatabaseHelper _dbHelper = DatabaseHelper();

  void initEditUser(User user) {
    getRoles();
    _title = 'Edit User';
    _initUser = user;
    cUsername.text = user.username;
    cPassword.text = user.password;
    cRePassword.text = user.password;
    _role = user.role;
    notifyListeners();
  }

  void initAddUser() {
    getRoles();
    _title = 'Add User';
    _initUser = null;
    cUsername.text = '';
    cPassword.text = '';
    cRePassword.text = '';
    _role = 'Administrator';
    notifyListeners();
  }

  Future<void> getRoles() async {
    try {
      final data = _dbHelper.getRoles();
      debugPrint(data.toString());
      roles = ['Administrator', 'Kasir', 'Admin'];
    } catch (e) {}
  }

  void initEditRole(Role role) {
    _title = 'Edit Role';
    _initRole = role;
    _namaRole = role.nama;
    cNamaRole.text = role.nama;
    _permission = role.permission.split('');
    notifyListeners();
  }

  void initAddRole() {
    _title = 'Add Role';
    _initRole = null;
    _namaRole = '';
    cNamaRole.text = '';
    _permission = ['0', '0', '0', '0', '0', '0', '0', '0'];
    notifyListeners();
  }

  void changePermission(int index, bool value) {
    if (value) {
      _permission[index] = '1';
    } else {
      _permission[index] = '0';
    }

    notifyListeners();
  }

  void addPermission(String namaRole, String permission) {
    debugPrint('$namaRole $permission');
  }

  //getter
  User? get initUser => _initUser;
  Role? get initRole => _initRole;
  String get role => _role;
  String get namaRole => _namaRole;
  List<String> get permission => _permission;
  String get title => _title;

  //setter
  set role(String value) {
    _role = value;
    notifyListeners();
  }

  set namaRole(String value) {
    _namaRole = value;
    notifyListeners();
  }

  set permission(List<String> value) {
    _permission = value;
    notifyListeners();
  }

  set title(String value) {
    _title = value;
    notifyListeners();
  }
}

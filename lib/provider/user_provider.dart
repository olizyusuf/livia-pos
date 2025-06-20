import 'package:flutter/material.dart';
import 'package:liviapos/model/role.dart';
import 'package:liviapos/model/user.dart';

import '../databases/db_helper.dart';

class UserProvider extends ChangeNotifier {
  User? _initUser;
  String? _initRole;
  String _role = 'Administrator';
  String _namaRole = '';
  List<String> _permission = [];
  String _title = '';
  String _message = '';

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

  // USER SCREEN
  void initEditUser(User user) async {
    await getRoles();
    _title = 'Edit User';
    _initUser = user;
    cUsername.text = user.username;
    cPassword.text = user.password;
    cRePassword.text = user.password;
    _role = user.role;
    notifyListeners();
  }

  void initAddUser() async {
    await getRoles();
    _title = 'Add User';
    _initUser = null;
    cUsername.text = '';
    cPassword.text = '';
    cRePassword.text = '';
    _role = 'Administrator';
    notifyListeners();
  }

  // ROLE SCREEN
  Future<void> getRoles() async {
    try {
      final data = await _dbHelper.getRoles();
      // debugPrint(data.length.toString());
      roles.clear();
      for (var d in data) {
        roles.add(d['nama']);
      }
      notifyListeners();
      // debugPrint(roles.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> initEditRole(String val) async {
    _title = 'Edit Role';
    _initRole = val;
    try {
      final data = await _dbHelper.getRoleByNama(val);
      // debugPrint(data.toString());
      _namaRole = data!.nama;
      cNamaRole.text = data.nama;
      _permission = data.permission.split('');
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }

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

  // INSERT ROLE
  Future<void> insertRole() async {
    if (cNamaRole.text.isEmpty || permission.isEmpty) {
      _message = 'Nama wajib di isi..';
      notifyListeners();
      return;
    }
    try {
      debugPrint(cNamaRole.text);
      debugPrint(_permission.join());
      await _dbHelper.insertRole(
          Role(nama: cNamaRole.text, permission: _permission.join()));
      getRoles();
      initAddRole();
      _message = 'Berhasil Disimpan';
    } catch (e) {
      _message = 'Gagal disimpan';
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<void> deleteRole() async {
    if (cNamaRole.text.isEmpty) {
      debugPrint('tidak ditemukan, gagal dihapus.');
    }
    try {
      await _dbHelper.deleteRole(_namaRole);
      debugPrint('Berhasil dihapus.');
    } catch (e) {
      debugPrint('Error, gagal dihapus.');
      debugPrint(e.toString());
    }
    getRoles();
    initAddRole();
    notifyListeners();
  }

  //getter
  User? get initUser => _initUser;
  String? get initRole => _initRole;
  String get role => _role;
  String get namaRole => _namaRole;
  List<String> get permission => _permission;
  String get title => _title;
  String get message => _message;

  //setter
  set setRole(String value) {
    _role = value;
    notifyListeners();
  }

  set setNamaRole(String value) {
    _namaRole = value;
    notifyListeners();
  }

  set setPermission(List<String> value) {
    _permission = value;
    notifyListeners();
  }

  set setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  set setMessage(String value) {
    _message = value;
    notifyListeners();
  }
}

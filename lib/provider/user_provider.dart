import 'package:flutter/material.dart';
import 'package:liviapos/model/role.dart';
import 'package:liviapos/model/user.dart';

import '../databases/db_helper.dart';

class UserProvider extends ChangeNotifier {
  String? _initUser;
  String? _initRole;
  String _role = 'ADMINISTRATOR';
  int? _idRole;
  String _namaRole = '';
  List<String> _permission = [];
  String _title = '';
  String _message = '';

  TextEditingController cUsername = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cRePassword = TextEditingController();
  TextEditingController cNamaRole = TextEditingController();

  List<String> roles = [];
  List<User> users = [];

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

  //// USER SCREEN /////////////
  void initEditUser(String val) async {
    await getRoles();
    _title = 'Edit User';

    try {
      final data = await _dbHelper.getUserByUsername(val);
      _initUser = val;
      cUsername.text = data!.username;
      cPassword.text = data.password;
      cRePassword.text = data.password;
      _role = data.role;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }

    notifyListeners();
  }

  void initAddUser() async {
    getRoles();
    _title = 'Add User';
    _initUser = null;
    cUsername.text = '';
    cPassword.text = '';
    cRePassword.text = '';
    _role = 'ADMINISTRATOR';
    notifyListeners();
  }

  Future<void> getUsers() async {
    try {
      final data = await _dbHelper.getUsers();
      users.clear();
      for (var d in data) {
        users.add(
          User(
              id: d['id'],
              username: d['username'],
              password: d['password'],
              role: d['role']),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //INSERT USER
  Future<void> insertUser() async {
    if (cUsername.text.isEmpty ||
        cPassword.text.isEmpty ||
        cRePassword.text.isEmpty) {
      _message = 'Masih ada yang kosong, Semua wajib di isi...';
      notifyListeners();
      return;
    }
    if (cPassword.text != cRePassword.text) {
      _message = 'Re-Password berbeda dengan Password...';
      notifyListeners();
      return;
    }
    try {
      await _dbHelper.insertUser(
        User(
          username: cUsername.text.toUpperCase(),
          password: cPassword.text,
          role: role.toUpperCase(),
        ),
      );
      _message = '${cUsername.text.toUpperCase()}, Berhasil Disimpan';
      getUsers();
    } catch (e) {
      _message = 'Gagal disimpan';
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<void> updateUser() async {
    if (cUsername.text.isEmpty ||
        cPassword.text.isEmpty ||
        cRePassword.text.isEmpty) {
      _message = 'Masih ada yang kosong, Semua wajib di isi...';
      notifyListeners();
      return;
    }
    if (cPassword.text != cRePassword.text) {
      _message = 'Re-Password berbeda dengan Password...';
      notifyListeners();
      return;
    }
    try {
      await _dbHelper.updateUser(
        User(
          username: cUsername.text.toUpperCase(),
          password: cPassword.text,
          role: role.toUpperCase(),
        ),
      );
      _message = '${cUsername.text.toUpperCase()}, Berhasil diperbaharui..';
      getUsers();
    } catch (e) {
      _message = 'Gagal diperbaharui';
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<void> deleteUser() async {
    if (cUsername.text.isEmpty) {
      _message = 'Tidak ditemukan, gagal dihapus.';
      notifyListeners();
      return;
    }
    try {
      _message = 'Berhasil dihapus';
      await _dbHelper.deleteUser(cUsername.text);
      getUsers();
    } catch (e) {
      debugPrint('Error, gagal dihapus.');
      debugPrint(e.toString());
      _message = 'Error, gagal dihapus.';
    }
    notifyListeners();
  }

  ////////

  /////// ROLE SCREEN //////
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
      _idRole = data!.id;
      _namaRole = data.nama.toUpperCase();
      cNamaRole.text = data.nama.toUpperCase();
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
    _message = '';
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
      _message = 'Nama wajib di isi...';
      notifyListeners();
      return;
    }
    try {
      debugPrint(cNamaRole.text);
      debugPrint(_permission.join());
      await _dbHelper.insertRole(Role(
          nama: cNamaRole.text.toUpperCase(), permission: _permission.join()));
      getRoles();
      initAddRole();
      _message = 'Berhasil Disimpan';
    } catch (e) {
      _message = 'Gagal disimpan';
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<void> udpateRole() async {
    if (cNamaRole.text.isEmpty || permission.isEmpty) {
      _message = 'Nama wajib di isi..';
      notifyListeners();
      return;
    }
    try {
      await _dbHelper.updateRole(Role(
          id: _idRole,
          nama: cNamaRole.text.toUpperCase(),
          permission: _permission.join()));
      getRoles();
      initAddRole();
      _message = 'Berhasil Diperbaharui';
    } catch (e) {
      _message = 'Gagal Diperbaharui';
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<void> deleteRole() async {
    if (cNamaRole.text.isEmpty) {
      _message = 'Tidak ditemukan, gagal dihapus.';
      notifyListeners();
      return;
    }
    try {
      _message = 'Berhasil dihapus';
      await _dbHelper.deleteRole(_namaRole);
      getRoles();
      initAddRole();
      debugPrint('Berhasil dihapus.');
    } catch (e) {
      debugPrint('Error, gagal dihapus.');
      debugPrint(e.toString());
      _message = 'Error, gagal dihapus.';
    }
    notifyListeners();
  }

  //getter
  String? get initUser => _initUser;
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

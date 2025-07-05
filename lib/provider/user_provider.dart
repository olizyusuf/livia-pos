import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:liviapos/model/user.dart';

import '../databases/db_helper.dart';

class UserProvider extends ChangeNotifier {
  final String _tableUser = 'users';

  int? _id;
  String? _username;
  String? _password;
  String? _role;
  String? _title;
  final List _users = [];
  String _message = '';

  int? get id => _id;
  String? get username => _username;
  String? get password => _password;
  String? get role => _role;
  String? get title => _title;
  List get users => _users;
  String get message => _message;

  set setRole(String val) {
    _role = val;
  }

  // TEXTFIELD CONTROLLER
  TextEditingController cUsername = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cRePassword = TextEditingController();
  TextEditingController cRole = TextEditingController();

  final DatabaseHelper _helperDb = DatabaseHelper();

  void initAddForm() {
    _title = 'Add User';
    _id = 0;
    _username = '';
    cUsername.clear();
    _password = '';
    cPassword.clear();
    cRePassword.clear();
    _role = 'ADMINISTRATOR';
    cRole.text = _role.toString();
    _message = '';
  }

  void initEditForm(String username) {
    _title = 'Edit User';
    getUserByUsername(username);
    cPassword.clear();
    cRePassword.clear();
    _message = '';
  }

  // SECURITY FOR HASH PASSWORD
  String _generateSalt([int length = 32]) {
    final random = Random.secure();
    final saltBytes =
        List<int>.generate(length, (index) => random.nextInt(256));
    return base64.encode(saltBytes);
  }

  String _hashPassword(String password, String salt) {
    final saltBytes = base64.decode(salt);
    final key = utf8.encode(password);
    final hmacSha256 = Hmac(sha256, saltBytes);
    final digest = hmacSha256.convert(key);
    return digest.toString();
  }

  Future<void> getUsers() async {
    try {
      final db = await _helperDb.database;
      final data = await db.query(_tableUser);
      _users.clear();
      for (var d in data) {
        _users.add(d);
      }
      debugPrint(users.length.toString());
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getUserByUsername(String val) async {
    try {
      final db = await _helperDb.database;
      final data = await db.query(
        _tableUser,
        where: 'username = ?',
        whereArgs: [val],
      );
      if (data.isNotEmpty) {
        final dataByUsername = User.fromMap(data.first);
        debugPrint(dataByUsername.toString());
        _id = dataByUsername.id;
        _username = dataByUsername.username;
        _role = dataByUsername.role;
        cUsername.text = dataByUsername.username;
        cRole.text = dataByUsername.role;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  Future<void> insertUser() async {
    try {
      if (cUsername.text.isEmpty ||
          cPassword.text.isEmpty ||
          cRePassword.text.isEmpty) {
        _message = 'Username, password, repassword masih ada yang kosong...';

        return;
      }
      if (cPassword.text != cRePassword.text) {
        _message = 'Password tidak sama...';
        return;
      }

      if (cUsername.text.length < 8 || cPassword.text.length < 8) {
        _message = 'Username dan password minimal 8 karakter...';
        return;
      }

      final db = await _helperDb.database;

      // enkripsi password
      final salt = _generateSalt();
      final hashedPassword = _hashPassword(cPassword.text, salt);

      // query
      await db.insert(
          _tableUser,
          User(
                  username: cUsername.text.toUpperCase(),
                  password: hashedPassword,
                  role: _role!)
              .toMap());

      _message = '$_username berhasil disimpan..';
      getUsers();
    } catch (e) {
      debugPrint(e.toString());
      _message = 'Error, telah terjadi kesalahan.. coba kembali..';
    }
    notifyListeners();
  }
}

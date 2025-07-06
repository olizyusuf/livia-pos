import 'package:flutter/material.dart';
import 'package:liviapos/helper/password_util.dart';
import 'package:liviapos/model/user.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<void> getUsers() async {
    try {
      final db = await _helperDb.database;
      final data = await db.query(_tableUser);
      _users.clear();
      for (var d in data) {
        _users.add(d);
      }
      // debugPrint(users.length.toString());
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

      if (cUsername.text.length < 4 || cPassword.text.length < 8) {
        _message =
            'Username minimal 4 karakter dan password minimal 8 karakter...';
        return;
      }

      //enkrip password
      final hashPassword = PasswordUtil.hashPassword(cPassword.text);

      final db = await _helperDb.database;
      // query
      await db.insert(
          _tableUser,
          User(
                  username: cUsername.text.toUpperCase(),
                  password: hashPassword,
                  role: _role!)
              .toMap());

      _message = '${cUsername.text.toUpperCase()} berhasil disimpan..';
      getUsers();
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        _message = 'Username sudah tersedia...';
      } else {
        debugPrint(e.toString());
        _message = 'Error, telah terjadi kesalahan.. coba kembali..';
      }
    }
    notifyListeners();
  }

  Future<void> updateUser() async {
    try {
      if (cPassword.text.isEmpty && cRePassword.text.isEmpty) {
        final db = await _helperDb.database;

        //query
        await db.rawUpdate('UPDATE $_tableUser SET role = ? WHERE username = ?',
            [_role, cUsername.text.toUpperCase()]);

        _message =
            '${cUsername.text.toUpperCase()} role berhasil diperbaharui..';
        getUsers();
        return;
      }

      if (cPassword.text.length < 8 || cPassword.text != cRePassword.text) {
        _message = 'Password minimal 8 karakter atau Repassword tidak sama...';
        return;
      }

      if (cPassword.text.isNotEmpty || cRePassword.text.isNotEmpty) {
        //enkrip password
        final hashPassword = PasswordUtil.hashPassword(cPassword.text);

        final db = await _helperDb.database;

        //query
        await db.rawUpdate(
            'UPDATE $_tableUser SET password = ? , role = ? WHERE username = ?',
            [hashPassword, _role, cUsername.text.toUpperCase()]);

        _message = 'Password berhasil diperbaharui..';
        getUsers();
        return;
      }
    } on DatabaseException catch (e) {
      debugPrint(e.toString());
      _message = 'Error, telah terjadi kesalahan.. coba kembali..';
    }

    notifyListeners();
  }

  Future<void> deleteUser() async {
    try {
      final db = await _helperDb.database;
      _message = '${cUsername.text.toUpperCase()} berhasil dihapus...';
      await db
          .delete(_tableUser, where: 'username = ?', whereArgs: [_username]);
      getUsers();
    } catch (e) {
      debugPrint(e.toString());
      _message = 'Error, telah terjadi kesalahan.. coba kembali..';
    }
    notifyListeners();
  }

  Future<void> cekLogin() async {
    try {
      final db = await _helperDb.database;
      final data = await db.query(
        _tableUser,
        where: 'username = ?',
        whereArgs: ['JONI'],
      );

      if (data.isNotEmpty) {
        final dataByUsername = User.fromMap(data.first);
        debugPrint(dataByUsername.toString());

        debugPrint(dataByUsername.password);

        if (PasswordUtil.verifyPassword('12345678', dataByUsername.password)) {
          debugPrint('password benar');
        } else {
          debugPrint('password salah');
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      _message = 'Error, telah terjadi kesalahan.. coba kembali..';
    }
  }
}

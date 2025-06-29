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
  String? _message;

  int? get id => _id;
  String? get username => _username;
  String? get password => _password;
  String? get role => _role;
  String? get title => _title;
  List get users => _users;
  String? get message => _message;

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
  }

  void initEditForm(String username) {
    _title = 'Edit User';
    getUserByUsername(username);
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
        _id = dataByUsername.id;
        _username = dataByUsername.username;
        _password = dataByUsername.password;
        _role = dataByUsername.role;
      }

      cUsername.text = _username.toString();
      cPassword.text = _password.toString();
      cRePassword.text = _password.toString();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

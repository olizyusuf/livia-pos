import 'package:flutter/material.dart';
import 'package:liviapos/databases/db_helper.dart';
import 'package:liviapos/model/role.dart';

class RoleProvider extends ChangeNotifier {
  final String _tableRole = 'Roles';

  int? _id;
  String? _nama;
  String? _permission;
  List? _roles;
  String? _message;

  int? get id => _id;
  String? get nama => _nama;
  String? get permission => _permission;
  List? get roles => _roles;
  String? get message => _message;

  final DatabaseHelper _helperDb = DatabaseHelper();

  Future<void> getRoles() async {
    try {
      final db = await _helperDb.database;

      //query
      String query = 'SELECT * FROM $_tableRole';
      final data = await db.rawQuery(query);

      for (var d in data) {
        _roles?.add(
          Role(
            id: int.parse(d['id'].toString()),
            nama: d['nama'].toString(),
            permission: d['permission'].toString(),
          ),
        );
      }

      debugPrint('cek list roles: ${_roles?.length}');
    } catch (e) {
      debugPrint(e.toString());
      _message = 'data gagal dimuat, ada kesalah..';
    }

    notifyListeners();
  }
}

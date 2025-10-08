import 'package:flutter/material.dart';
import 'package:liviapos/databases/db_helper.dart';
import 'package:liviapos/model/role.dart';

class RoleProvider extends ChangeNotifier {
  final String _tableRole = 'Roles';
  String _title = '';

  int? _id;
  String? _nama;
  List? _permission;
  final List _roles = [];
  String? _message;

  // menu list for permission
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

  String get title => _title;
  int? get id => _id;
  String? get nama => _nama;
  List? get permission => _permission;
  List get roles => _roles;
  String? get message => _message;

  // TEXTFIELD CONTROLLER
  TextEditingController cNama = TextEditingController();

  final DatabaseHelper _helperDb = DatabaseHelper();

  void initAddForm() {
    _title = 'Add Role';
    _nama = '';
    cNama.clear();
    _permission = ['0', '0', '0', '0', '0', '0', '0', '0'];
    _message = '';
  }

  void initEditForm(String nama) {
    _title = 'Edit Role';
    getRoleByNama(nama);
  }

  Future<void> getRoles() async {
    try {
      final db = await _helperDb.database;

      final data = await db.query(_tableRole);
      _roles.clear();
      for (var d in data) {
        _roles.add(d);
      }

      // debugPrint(_roles.length.toString());
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _message = 'data gagal dimuat, ada kesalah..';
    }
  }

  Future<void> getRoleByNama(String val) async {
    try {
      final db = await _helperDb.database;

      //query
      final data = await db.query(
        _tableRole,
        where: 'nama = ?',
        whereArgs: [val],
      );

      if (data.isNotEmpty) {
        final dataByNama = Role.fromMap(data.first);
        _id = dataByNama.id;
        _nama = dataByNama.nama;
        _permission = dataByNama.permission.split('');
      }

      cNama.text = _nama.toString();

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _message = 'data gagal dimuat, ada kesalah..';
    }
  }

  Future<void> insertRole(Role role) async {
    if (role.nama.isEmpty || role.permission.isEmpty) {
      _message = 'Nama atau Permission mohon di isi..';
      return;
    }
    try {
      final db = await _helperDb.database;

      //query
      await db.insert(_tableRole, role.toMap());

      _message = '${cNama.text.toUpperCase()} berhasil disimpan..';
      getRoles();
    } catch (e) {
      debugPrint(e.toString());
      _message = 'data gagal disimpan, ada kesalah..';
    }
    notifyListeners();
  }

  Future<void> updateRole() async {
    if (_nama!.isEmpty || permission!.isEmpty) {
      _message = 'Nama atau Permission mohon di isi..';
      return;
    }
    try {
      final db = await _helperDb.database;

      Role updateData = Role(
          id: id!,
          nama: cNama.text.toUpperCase(),
          permission: _permission!.join(''));

      //query
      await db.update(_tableRole, updateData.toMap(),
          where: 'nama = ?', whereArgs: [updateData.nama]);

      _message = '${cNama.text.toUpperCase()} berhasil diperbaharui..';

      getRoles();
    } catch (e) {
      debugPrint(e.toString());
      _message = 'Data gagal diperbaharui, ada kesalah..';
    }
    notifyListeners();
  }

  Future<void> deleteRole() async {
    try {
      final db = await _helperDb.database;
      _message = '$_nama telah berhasil dihapus..';
      //query
      await db.delete(_tableRole, where: 'nama = ?', whereArgs: [_nama]);

      getRoles();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changePermission(int index, bool value) {
    if (value) {
      _permission?[index] = '1';
    } else {
      _permission?[index] = '0';
    }
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:liviapos/databases/db_helper.dart';
import 'package:liviapos/model/role.dart';

class RoleProvider extends ChangeNotifier {
  // variable tabel dan title
  final String _tableRole = 'Roles';
  String _title = '';

  // variable
  int? _id;
  String? _nama;
  List? _permission;
  final List _roles = [];
  String? _message;
  List? _menu;

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

  // getter untuk variable private
  String get title => _title;
  int? get id => _id;
  String? get nama => _nama;
  List? get permission => _permission;
  List get roles => _roles;
  String? get message => _message;
  List? get menu => _menu;

  // Controller Textfield
  TextEditingController cNama = TextEditingController();

  // inisialisasi database helper
  final DatabaseHelper _helperDb = DatabaseHelper();

  // dispose widget
  @override
  void dispose() {
    cNama.dispose();
    super.dispose();
  }

  // init untuk form tambah role
  void initAddForm() {
    _title = 'Add Role';
    _nama = '';
    cNama.clear();
    _permission = ['0', '0', '0', '0', '0', '0', '0', '0'];
    _message = '';
  }

  // init untuk edit role
  void initEditForm(String nama) {
    _title = 'Edit Role';
    getRoleByNama(nama);
  }

  // fungsi mendapat semua data role didalam tabel 'Roles'
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

  // fungsi mendapat satu data role dengan nama
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

  // fungsi menambah data role ke table 'Roles'
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

  // fungsi update satu data role di dalam tabel 'Roles'
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

  // fungsi menghapus satu data role di dalam tabel 'Roles'
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

  // fungsi mengganti pada data list Permission
  void changePermission(int index, bool value) {
    if (value) {
      _permission?[index] = '1';
    } else {
      _permission?[index] = '0';
    }
    notifyListeners();
  }

  // fungsi mendapatkan permission disalah satu data role
  Future<void> getPermission(String name) async {
    try {
      final db = await _helperDb.database;

      //query
      final data = await db.query(
        _tableRole,
        where: 'nama = ?',
        whereArgs: [name],
      );

      if (data.isNotEmpty) {
        final dataByNama = Role.fromMap(data.first);
        _menu = dataByNama.permission.split('');
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _message = 'data gagal dimuat, ada kesalah..';
    }
  }
}

import 'package:flutter/material.dart';
import 'package:liviapos/databases/db_helper.dart';
import 'package:liviapos/model/kategori.dart';
import 'package:liviapos/model/produk.dart';
import 'package:sqflite/sqflite.dart';

class MasterProvider extends ChangeNotifier {
  // inisialisasi database helper
  final DatabaseHelper _helperDb = DatabaseHelper();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = '';
  String get message => _message;

  // TABLE KATEGORI
  final String _tableKategori = 'kategori';
  int? _idKategori;
  String? _namaKategori;
  final List _kategori = [];
  //setter dan gettter
  int? get idKategori => _idKategori;
  String? get namaKategori => _namaKategori;

  List get kategori => _kategori;

  // TABLE PRODUK
  final List _produk = [];
  //setter dan gettter
  List get produk => _produk;

  // TEXTFIELD CONTROLLER
  TextEditingController cNamaKategori = TextEditingController();

  TextEditingController cKodeProduk = TextEditingController();
  TextEditingController cBarcode = TextEditingController();
  TextEditingController cNamaProduk = TextEditingController();
  TextEditingController cQty = TextEditingController();
  TextEditingController cHBeli = TextEditingController();
  TextEditingController cHJual = TextEditingController();
  TextEditingController cSatuan = TextEditingController();
  TextEditingController cKategori = TextEditingController();

  // Fungsi kategori
  // get all kategori
  Future<void> getKategori() async {
    try {
      final db = await _helperDb.database;
      final data = await db.query(_tableKategori);
      _kategori.clear();
      for (var d in data) {
        _kategori.add(d);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // cari id kategori berikutnya (3 diti berututan)
  Future<int> _getNextKategoriId() async {
    try {
      // init db
      final db = await _helperDb.database;

      // query db
      final kategori =
          await db.query('kategori', columns: ['id'], orderBy: 'id ASC');

      // jika tidak ada data dalam kategori mulai dari 1;
      if (kategori.isEmpty) return 1;

      // mencari gap didalam urutan id
      for (int i = 0; i < kategori.length; i++) {
        int currentId = kategori[i]['id'] as int;
        int expectedId = i + 1;

        if (currentId != expectedId) {
          return expectedId;
        }
      }

      // jika tidak ada gap, kembalikan id setelah yang terakhir
      int lastId = kategori.last['id'] as int;
      return lastId + 1;
    } catch (e) {
      debugPrint(e.toString());
      throw '';
    }
  }

  // get kategori by id
  Future<void> getKategoriById(String id) async {
    try {
      // init db
      final db = await _helperDb.database;
      final data = await db.query(
        _tableKategori,
        where: 'id = ?',
        whereArgs: [id],
      );
      // jika data tidak kosong, ambil data pertama dan deklarasi ke variabel
      if (data.isNotEmpty) {
        final dataKategoriById = Kategori.fromMap(data.first);

        _idKategori = dataKategoriById.id;
        _namaKategori = dataKategoriById.nama;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  // insert kategori dengan id 3 digit berurutan
  Future<void> insertKategori() async {
    try {
      // validasi textfiel nama kategori tidak boleh kosong..
      if (cKategori.text.isEmpty) {
        _message = 'Nama kategori masih kosong...';

        return;
      }

      Kategori? kategori;
      // init db
      final db = await _helperDb.database;

      // init id kategori terakhir
      int nextId = await _getNextKategoriId();

      // cek tidak lebih dari 3 digit 999
      if (nextId > 999) {
        _message = 'Max kategori limit';
        return;
      }

      // set id kategori
      kategori!.id = nextId;
      kategori.nama = cKategori.text.toUpperCase();

      // query
      await db.insert(_tableKategori, kategori.topMap());

      _message = '${cKategori.text.toUpperCase()}Data Berhasil ditambah';
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        _message = 'Kategori sudah tersedia...';
      } else {
        debugPrint(e.toString());
        _message = 'Error, telah terjadi kesalahan.. coba kembali..';
      }
    }
    cKategori.clear();
    notifyListeners();
  }

  // update kategori
  Future<void> updateKategori() async {
    try {
      // init db
      final db = await _helperDb.database;

      Kategori? kategori;
      kategori!.id = _idKategori;
      kategori.nama = cNamaKategori.text;

      // query update kategori
      if (cNamaKategori.text.isNotEmpty) {
        await db.update(_tableKategori, kategori.topMap(),
            where: 'id = ?', whereArgs: [kategori.id]);
        _message = 'Update Kategori berhasil...';
      } else {
        _message = 'Nama Kategori kosong...';
      }
    } on DatabaseException catch (e) {
      debugPrint(e.toString());
      if (e.isUniqueConstraintError()) {
        _message = 'Kategori sudah tersedia...';
      } else {
        debugPrint(e.toString());
        _message = 'Error, telah terjadi kesalahan.. coba kembali..';
      }
    }
  }

  // hapus kategori
  Future<int> deleteKategori(int id) async {
    try {
      // init db
      final db = await _helperDb.database;

      // cek data kategori apakah ada

      // query hapus kategori
      final dataKategori =
          await db.delete('kategori', where: 'id = ?', whereArgs: [id]);

      return dataKategori;
    } catch (e) {
      debugPrint(e.toString());
      throw '';
    }
  }
}

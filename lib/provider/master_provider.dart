import 'package:flutter/material.dart';
import 'package:liviapos/databases/db_helper.dart';
import 'package:liviapos/model/kategori.dart';

class MasterProvider extends ChangeNotifier {
  // inisialisasi database helper
  final DatabaseHelper _helperDb = DatabaseHelper();

  // TABLE KATEGORI

  // TABLE PRODUK

  // Fungsi kategori
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

  // insert kategori dengan id 3 digit berurutan
  Future<int> insertKategori(Kategori kategori) async {
    try {
      // init db
      final db = await _helperDb.database;

      // init id kategori terakhir
      int nextId = await _getNextKategoriId();

      // cek tidak lebih dari 3 digit 999
      if (nextId > 999) {
        throw Exception('Max kategori limit');
      }

      // set id kategori
      kategori.id = nextId;

      // query
      final dataKategori = await db.insert('kategori', kategori.topMap());

      return dataKategori;
    } catch (e) {
      debugPrint(e.toString());
      throw '';
    }
  }
}

class Master {
  int? id;
  String? kodeProduk;
  String? barcode;
  String? nama;
  double? qty;
  double? hargaBeli;
  double? hargaJual;
  String? satuan;
  String? kategori;

  Master(
      {this.id,
      required this.kodeProduk,
      required this.barcode,
      required this.nama,
      required this.qty,
      required this.hargaBeli,
      required this.hargaJual,
      required this.satuan,
      required this.kategori});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kode_produk': kodeProduk,
      'barcode': barcode,
      'nama': nama,
      'qty': qty,
      'h_beli': hargaBeli,
      'h_jual': hargaJual,
      'satuan': satuan,
      'kategori': kategori,
    };
  }

  factory Master.fromMap(Map<String, dynamic> map) {
    return Master(
        id: map['id'],
        kodeProduk: map['kode_produk'],
        barcode: map['barocde'],
        nama: map['nama'],
        qty: map['qty'],
        hargaBeli: map['h_beli'],
        hargaJual: map['h_jual'],
        satuan: map['satuan'],
        kategori: map['kategori']);
  }
}

class Kategori {
  int? id;
  String nama;

  Kategori({this.id, required this.nama});

  Map<String, dynamic> topMap() {
    return {
      'id': id,
      'nama': nama,
    };
  }

  factory Kategori.fromMap(Map<String, dynamic> map) {
    return Kategori(
      id: map['id'],
      nama: map['nama'],
    );
  }
}

class Role {
  final int? id;
  final String nama;
  final String permission;

  Role({this.id, required this.nama, required this.permission});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'permission': permission,
    };
  }
}

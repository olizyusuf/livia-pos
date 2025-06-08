class User {
  final int? id;
  final String? username;
  final String? password;
  final String? role;

  User({this.id, this.username, this.password, this.role});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'role': role,
    };
  }
}

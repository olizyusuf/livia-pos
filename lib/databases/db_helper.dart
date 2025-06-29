import 'package:liviapos/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static const _databaseName = "liviapos.db";
  static const _databaseVersion = 1;

  static const rolesTable = 'roles';
  static const usersTable = 'users';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, _databaseName);

    return await openDatabase(
      dbPath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    // table roles + default data
    await db.execute('''
      CREATE TABLE $rolesTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT UNIQUE NOT NULL,
      permission TEXT NOT NULL
      );
    ''');
    await db.insert(
      rolesTable,
      {'id': 1, 'nama': 'ADMINISTRATOR', 'permission': '11111111'},
    );
    // table users + default data
    await db.execute('''
      CREATE TABLE $usersTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT UNIQUE NOT NULL,
      password TEXT NOT NULL,
      role TEXT NOT NULL
      );
    ''');
    await db.insert(
      usersTable,
      {
        'id': 1,
        'username': 'ADMIN',
        'password': '11111111',
        'role': 'ADMINISTRATOR'
      },
    );
  }

  // USERS CRUD
  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return db.query(usersTable);
  }

  Future<User?> getUserByUsername(String username) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      usersTable,
      where: 'username = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(usersTable, user.toMap());
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    // return await db.update(usersTable, user.toMap(),
    //     where: 'username = ?', whereArgs: [user.username]);
    return await db.rawUpdate(
        'UPDATE $usersTable SET password = ?, role = ? WHERE username = ?',
        [user.password, user.role, user.username]);
  }

  Future<int> deleteUser(String user) async {
    final db = await database;
    return await db
        .delete(usersTable, where: 'username = ?', whereArgs: [user]);
  }
}

import 'package:liviapos/helper/password_util.dart';
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
        'password': PasswordUtil.hashPassword('11111111'),
        'role': 'ADMINISTRATOR'
      },
    );
  }
}

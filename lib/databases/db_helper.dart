import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static const _databaseName = "liviapos.db";
  static const _databaseVersion = 1;

  static const roleTable = 'roles';

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
      CREATE TABLE $roleTable(
      id INT PRIMARY KEY AUTOINCREMENT,
      nama TEXT UNIQUE,
      permission TEXT,
      )
    ''');
    await db.insert(
      roleTable,
      {'id': 1, 'nama': 'Administrator', 'permission': '11111111'},
    );
  }

  //ROLE CRUD
  Future<List<Map<String, dynamic>>> getRoles() async {
    final db = await database;
    return db.query(roleTable);
  }
}

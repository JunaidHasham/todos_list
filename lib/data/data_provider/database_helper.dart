import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._internal();

  static final DatabaseHelper _singleton = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _singleton;
  }

  static Database? _database;

  Future<Database> get db async {
    if (_database != null) return _database!;

    _database = await _initializeDatabase();

    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'todos_list.db');

    final database = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );

    return database;
  }

  Future<void> _onCreate(Database db, int version) async {
    return db.execute(
      'CREATE TABLE ToDos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, status INTEGER)',
    );
  }
}

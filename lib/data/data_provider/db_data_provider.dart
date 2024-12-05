import 'package:sqflite/sqflite.dart';

import '../models/todos.dart';
import 'database_helper.dart';

class DbDataProvider {
  Future<int> addEntry(ToDos todos) async {
    print('todos = ${todos.toString()}');

    Database database = await DatabaseHelper().db;

    int insertedValue = await database.insert(
      'ToDos',
      todos.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return insertedValue;
  }

  Future<List<Map<String, dynamic>>> getEntries() async {
    Database database = await DatabaseHelper().db;

    List<Map<String, Object?>> entriesList = await database.query('ToDos');

    return entriesList;
  }

  Future<List<Map<String, dynamic>>> getFilterEntries(int status) async {
    Database database = await DatabaseHelper().db;

    List<Map<String, Object?>> entriesList =
        await database.rawQuery('SELECT * FROM ToDos WHERE status = $status');

    return entriesList;
  }

  Future<int> updateTodos(int id) async {
    Database database = await DatabaseHelper().db;

    List<Map<String, Object?>> entriesList =
        await database.rawQuery('update ToDos set status = 1 where id = $id');

    return entriesList.length;
  }

  Future<int> deleteTodos(int id) async {
    Database database = await DatabaseHelper().db;

    int deletedValue = await database.delete(
      'ToDos',
      where: 'id = ?',
      whereArgs: [id],
    );

    return deletedValue;
  }
}

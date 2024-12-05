import 'package:todos_list/data/data_provider/db_data_provider.dart';

import '../models/todos.dart';

class DatabaseRepository {
  DbDataProvider _dbDataProvider = DbDataProvider();

  Future<int> addTodos(String title) async {
    ToDos toDos = ToDos(
      id: 0,
      title: title,
      status: 0, // initially incomplete
    );

    int value = await _dbDataProvider.addEntry(toDos);

    print('inserted values = $value');

    return value;
  }

  Future<List<ToDos>> getTodosList(int? id) async {
    List<ToDos> todosList = [];

    List<Map<String, Object?>> entriesList = [];

    if (id != null) {
      entriesList = await _dbDataProvider.getFilterEntries(id);
    } else {
      entriesList = await _dbDataProvider.getEntries();
    }

    for (var i in entriesList) {
      todosList.add(ToDos.fromJson(i));
    }

    print('todosList = ${todosList.length}');
    for (var i in todosList) print(i.toString());

    return todosList;
  }

  Future<int> updateTodos(int id) async {
    int update = await _dbDataProvider.updateTodos(id);

    print('update = $update');

    return update;
  }

  Future<int> deleteTodos(int id) async {
    int delete = await _dbDataProvider.deleteTodos(id);

    print('delete = $delete');

    return delete;
  }
}

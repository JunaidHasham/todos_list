import 'package:equatable/equatable.dart';
import 'package:todos_list/data/models/todos.dart';

import '../data/models/device.dart';

abstract class ToDoStates extends Equatable {
  const ToDoStates();

  @override
  List<Object?> get props => [];
}

class Initial extends ToDoStates {}

class Loading extends ToDoStates {}

class ApiDataSuccess extends ToDoStates {
  final List<Device> deviceList;

  const ApiDataSuccess(this.deviceList);
}

class ToDosListSuccess extends ToDoStates {
  final List<ToDos> todosList;

  const ToDosListSuccess(this.todosList);
}

class Failure extends ToDoStates {
  final errorMessage;

  const Failure(this.errorMessage);
}

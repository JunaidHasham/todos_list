import 'package:equatable/equatable.dart';

abstract class ToDoEvents extends Equatable {
  const ToDoEvents();

  @override
  List<Object?> get props => [];
}

class GetApiData extends ToDoEvents {}

class AddTodo extends ToDoEvents {
  final String title;

  const AddTodo(this.title);
}

class GetTodoList extends ToDoEvents {
  final int? status;

  const GetTodoList(this.status);
}

class UpdateTodos extends ToDoEvents {
  final int id;
  const UpdateTodos(this.id);
}

class DeleteTodos extends ToDoEvents {
  final int id;
  const DeleteTodos(this.id);
}

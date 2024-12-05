import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_list/business_logic/to_do_events.dart';
import 'package:todos_list/business_logic/to_do_states.dart';
import 'package:todos_list/data/repository/api_repository.dart';
import 'package:todos_list/data/repository/database_repository.dart';

import '../data/models/device.dart';
import '../data/models/todos.dart';

class ToDoBloc extends Bloc<ToDoEvents, ToDoStates> {
  ToDoBloc() : super(Initial()) {
    ApiRepository apiRepository = ApiRepository();
    DatabaseRepository databaseRepository = DatabaseRepository();

    on<GetApiData>((event, emit) async {
      emit(Loading());

      try {
        print('Loading API Data!');

        List<Device>? deviceList = await apiRepository.getDeviceList();

        emit(ApiDataSuccess(deviceList));
      } catch (e) {
        print('Exception : ${e.toString()}');
        emit(Failure(e.toString()));
      }
    });

    on<AddTodo>((event, emit) async {
      try {
        emit(Loading());

        await databaseRepository.addTodos(event.title);

        List<ToDos> todosList = await databaseRepository.getTodosList(null);

        emit(ToDosListSuccess(todosList));
      } catch (e) {
        emit(Failure(e.toString()));
      }
    });

    on<GetTodoList>((event, emit) async {
      emit(Loading());

      try {
        List<ToDos> todosList =
            await databaseRepository.getTodosList(event.status);

        emit(ToDosListSuccess(todosList));
      } catch (e) {
        emit(Failure(e.toString()));
      }
    });

    on<UpdateTodos>((event, emit) async {
      emit(Loading());

      try {
        int update = await databaseRepository.updateTodos(event.id);

        List<ToDos> todosList = await databaseRepository.getTodosList(null);

        emit(ToDosListSuccess(todosList));
      } catch (e) {
        emit(Failure(e.toString()));
      }
    });

    on<DeleteTodos>((event, emit) async {
      emit(Loading());

      try {
        int update = await databaseRepository.deleteTodos(event.id);

        List<ToDos> todosList = await databaseRepository.getTodosList(null);

        emit(ToDosListSuccess(todosList));
      } catch (e) {
        emit(Failure(e.toString()));
      }
    });
  }
}

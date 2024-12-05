import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_list/business_logic/to_do_events.dart';

import '../business_logic/to_do_states.dart';
import '../business_logic/todo_bloc.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ToDoBloc>(context).add(GetTodoList(null));
  }

  final TextEditingController _titleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade300,
        onPressed: () {
          _titleController.clear();

          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            isScrollControlled: true,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      'New Task',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Add your task here.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Task!';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 28),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('Form is validated!');

                            BlocProvider.of<ToDoBloc>(context).add(
                              AddTodo(_titleController.text.trim()),
                            );

                            _titleController.clear();
                            Navigator.pop(context);
                          } else {
                            print('Form is not validated!');
                          }
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ]),
                ),
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 32,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.blue,
      body: BlocListener<ToDoBloc, ToDoStates>(
        listener: (context, state) {},
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.format_list_bulleted,
                      size: 34,
                      color: Colors.blue.shade600,
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'ToDos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 42,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: BlocBuilder<ToDoBloc, ToDoStates>(
                          builder: (context, state) {
                            if (state is ToDosListSuccess) {
                              return Text(
                                '${state.todosList.length} Tasks',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return Text(
                                '0 Tasks',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Center(
                                child: Text(
                                  'Select filter type!',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);

                                      BlocProvider.of<ToDoBloc>(context)
                                          .add(GetTodoList(null));
                                    },
                                    child: Text('All'),
                                    style: ButtonStyle(
                                      foregroundColor: WidgetStatePropertyAll(
                                        Colors.blue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);

                                      BlocProvider.of<ToDoBloc>(context)
                                          .add(GetTodoList(1));
                                    },
                                    child: Text('Completed'),
                                    style: ButtonStyle(
                                      foregroundColor: WidgetStatePropertyAll(
                                        Colors.green,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);

                                      BlocProvider.of<ToDoBloc>(context)
                                          .add(GetTodoList(0));
                                    },
                                    child: Text('Pending'),
                                    style: ButtonStyle(
                                      foregroundColor: WidgetStatePropertyAll(
                                        Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.filter_alt_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
              padding: EdgeInsets.all(16),
              child: BlocBuilder<ToDoBloc, ToDoStates>(
                builder: (context, state) {
                  if (state is Initial) {
                    return SizedBox();
                  } else if (state is ToDosListSuccess) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(
                            state.todosList[index].title ?? '',
                            style: TextStyle(
                              decoration: state.todosList[index].status == 1
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          value: state.todosList[index].status == 1,
                          activeColor: Colors.blue,
                          onChanged: (value) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'Do you want to Complete or Delete the Task?',
                                  style: TextStyle(fontSize: 18),
                                ),
                                content: Row(children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        print('Deleting the task!');

                                        Navigator.pop(context);

                                        BlocProvider.of<ToDoBloc>(context).add(
                                          DeleteTodos(
                                              state.todosList[index].id),
                                        );
                                      },
                                      child: Text('Delete'),
                                      style: ButtonStyle(
                                        foregroundColor: WidgetStatePropertyAll(
                                          Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: state.todosList[index].status != 1,
                                    child: SizedBox(width: 8),
                                  ),
                                  Visibility(
                                    visible: state.todosList[index].status != 1,
                                    child: Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          print(
                                              'Updating/Completing the task!');

                                          Navigator.pop(context);

                                          BlocProvider.of<ToDoBloc>(context)
                                              .add(
                                            UpdateTodos(
                                                state.todosList[index].id),
                                          );
                                        },
                                        child: Text('Complete'),
                                        style: ButtonStyle(
                                          foregroundColor:
                                              WidgetStatePropertyAll(
                                            Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          },
                        );
                      },
                      itemCount: state.todosList.length,
                    );
                  } else if (state is Loading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}

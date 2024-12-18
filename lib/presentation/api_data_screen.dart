import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_list/business_logic/to_do_events.dart';
import 'package:todos_list/business_logic/to_do_states.dart';
import 'package:todos_list/business_logic/todo_bloc.dart';
import 'package:todos_list/data/models/device.dart';
import 'package:todos_list/presentation/todos_screen.dart';

class ApiDataScreen extends StatelessWidget {
  const ApiDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: BlocProvider(
        create: (context) => ToDoBloc()..add(GetApiData()),
        child: BlocListener<ToDoBloc, ToDoStates>(
          listener: (context, state) {
            if (state is Failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: ListView(children: [
                    SizedBox(height: 18),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TodosScreen()),
                            (_) => false,
                          );
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.format_list_bulleted,
                            size: 34,
                            color: Colors.blue.shade600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Text(
                      'Devices (API)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: BlocBuilder<ToDoBloc, ToDoStates>(
                        builder: (context, state) {
                          if (state is ApiDataSuccess) {
                            return Text(
                              '${state.deviceList.length} Devices',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            );
                          } else {
                            return Text(
                              '0 Devices',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ]),
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
                    } else if (state is ApiDataSuccess) {
                      print('\nChief : state is ApiDataSuccess :: 2');

                      return ListView.separated(
                        itemBuilder: (context, index) => ExpansionTile(
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          leading: CircleAvatar(
                            radius: 18,
                            child: Center(
                              child: Text(state.deviceList[index].id),
                            ),
                          ),
                          title: Text(state.deviceList[index].name),
                          childrenPadding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          children: state.deviceList[index].data != null
                              ? getChildData(state.deviceList[index].data!)
                              : [],
                        ),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: state.deviceList.length,
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
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getChildData(Data data) {
    List<Widget> children = [];

    if (data.color1 != null) {
      children.add(
        ChildDataWidget(title: 'color', subTitle: data.color1!),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.color2 != null) {
      children.add(
        ChildDataWidget(title: 'Color', subTitle: data.color2!),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.capacity1 != null) {
      children.add(
        ChildDataWidget(title: 'capacity', subTitle: data.capacity1!),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.capacityInGB != null) {
      children.add(
        ChildDataWidget(
            title: 'capacity GB', subTitle: data.capacityInGB!.toString()),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.price1 != null) {
      children.add(
        ChildDataWidget(title: 'price', subTitle: data.price1!.toString()),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.generation1 != null) {
      children.add(
        ChildDataWidget(title: 'generation', subTitle: data.generation1!),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.year != null) {
      children.add(
        ChildDataWidget(title: 'Capacity', subTitle: data.year!.toString()),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.cpuModel != null) {
      children.add(
        ChildDataWidget(title: 'CPU model', subTitle: data.cpuModel!),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.hardDiskSize != null) {
      children.add(
        ChildDataWidget(title: 'Hard disk size', subTitle: data.hardDiskSize!),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.strapColour != null) {
      children.add(
        ChildDataWidget(title: 'Strap Colour', subTitle: data.strapColour!),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.caseSize != null) {
      children.add(
        ChildDataWidget(title: 'Case Size', subTitle: data.caseSize!),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.description != null) {
      children.add(
        ChildDataWidget(title: 'Description', subTitle: data.description!),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.capacity2 != null) {
      children.add(
        ChildDataWidget(title: 'Capacity', subTitle: data.capacity2!),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.screenSize != null) {
      children.add(
        ChildDataWidget(
            title: 'Screen size', subTitle: data.screenSize!.toString()),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.generation2 != null) {
      children.add(
        ChildDataWidget(title: 'Generation', subTitle: data.generation2!),
      );
      children.add(SizedBox(height: 8));
    }

    if (data.price2 != null) {
      children.add(
        ChildDataWidget(title: 'Price', subTitle: data.price2!),
      );
      children.add(SizedBox(height: 8));
    }

    return children;
  }
}

class ChildDataWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const ChildDataWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
              subTitle,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}

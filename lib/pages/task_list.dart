import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todoflutter/database/task_db_helper.dart';
import 'package:todoflutter/pages/task_list_cubit.dart';
import 'package:todoflutter/pages/task_list_cubit_state.dart';

import '../bloc/base_state/base_bloc_state.dart';
import '../datasource/app_repository.dart';
import '../model/task.dart';
import '../util/dialog_box.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        child: const Icon(Icons.add, size: 20),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TaskListCubit>().fetchTasks(refresh: false);
          return;
        },
        child: Center(
          child: BlocBuilder<TaskListCubit, BaseBlocState<TaskListState>>(
            builder: (context, baseState) {
              print("BlocBuilder: state: $baseState");
              return baseState.when(
                init: () {
                  context.read<TaskListCubit>().fetchTasks(refresh: false);
                  return SizedBox.shrink();
                },
                loading: () => Center(child: CircularProgressIndicator()),
                loaded: (pageState) => _processPageState(pageState),
                error: (error) => Center(
                  child: Text("Something went wrong: ${error.toString()}"),
                ),
              );
            },
          ),
        ),
      ),
      // FutureBuilder<List<Task>>(
      //     future: TaskDbHelper().getTasks(),
      //     builder: (context, snapshot) {
      //       switch (snapshot.connectionState) {
      //         case ConnectionState.none:
      //           return const Text("no data");
      //         case ConnectionState.waiting:
      //           return const CircularProgressIndicator();
      //         case ConnectionState.done:
      //           if (snapshot.hasData) {
      //             return getTasksList(snapshot.data!);
      //           }
      //       }
      //       return Container();
      //     }),
    );
  }

  Widget _processPageState(TaskListState pageState) {
    return pageState.when(
        taskLoaded: (tasks) => ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task task = tasks[index];

              return Text(task.taskName);
            })
        //     ListView.builder(
        //   itemCount: photos.length,
        //   itemBuilder: (BuildContext context, int index) => Dismissible(
        //     //onDismissed: (direction) => context.read<TaskListCubit>().deletePhoto(photos[index]),
        //     key: UniqueKey(),
        //     child: InkWell(
        //       onTap: () => _showEditDialog(photos[index], context),
        //       child: ListTile(
        //         leading: Image.network(photos[index].thumbnailUrl),
        //         title: Text(photos[index].title),
        //         trailing: InkWell(
        //           onTap: () => _share(photos[index]),
        //           child: Icon(Icons.share),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        );
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void saveNewTask() async {
    // await TaskDbHelper().addTask(_controller.text);
    // setState(() {});
    context
        .read<TaskListCubit>()
        .addTask(Task(taskName: _controller.text, completed: false));
    _controller.clear();
    Navigator.of(context).pop();
  }

  Widget getTasksList(List<Task> tasks) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks[index];
          return Text(task.taskName);
        });
  }
}

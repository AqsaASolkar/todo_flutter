import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoflutter/pages/task_list_cubit.dart';
import 'package:todoflutter/pages/task_list_cubit_state.dart';
import 'package:todoflutter/util/todo_tile.dart';

import '../bloc/base_state/base_bloc_state.dart';
import '../model/task.dart';
import '../util/dialog_box.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final _controller = TextEditingController();
  int selectedIndex = 0;

  onTabChanged(int index) {
    switch (index) {
      case 0:
        context.read<TaskListCubit>().fetchPendingTasks(refresh: false);
        break;
      case 1:
        context.read<TaskListCubit>().fetchCompletedTask(refresh: false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Todo App",
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white.withOpacity(0.7),
          selectedItemColor: Colors.white,
          onTap: (index) => setState(() {
            selectedIndex = index;
            onTabChanged(index);
          }),
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined),
              label: 'Todos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done, size: 28),
              label: 'Completed',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            createNewTask();
          },
          child: const Icon(Icons.add, size: 20),
        ),
        body: pendingTaskList());
  }

  Widget pendingTaskList() {
    return Center(
      child: BlocBuilder<TaskListCubit, BaseBlocState<TaskListState>>(
        builder: (context, baseState) {
          //print("BlocBuilder: state: $baseState");
          return baseState.when(
            init: () {
              return const SizedBox.shrink();
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (pageState) => _processPageState(pageState),
            error: (error) => Center(
              child: Text("Something went wrong: ${error.toString()}"),
            ),
          );
        },
      ),
    );
  }

  Widget _processPageState(TaskListState pageState) {
    return pageState.when(
        taskLoaded: (tasks) => ListView.builder(
            //scrollDirection: Axis.horizontal,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task task = tasks[index];
              return ToDoTile(
                taskName: task.taskName,
                taskCompleted: task.completed,
                onChanged: (value) => checkBoxChanged(task, value),
                deleteFunction: () => deleteTask(task),
              );
            }));
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

  checkBoxChanged(Task task, bool? value) {
    task.completed = value ?? false;
    context
        .read<TaskListCubit>()
        .updateTask(task, isCompletedTask: selectedIndex == 0 ? false : true);
  }

  void saveNewTask() async {
    context.read<TaskListCubit>().addTask(
        Task(taskName: _controller.text, completed: false),
        isCompletedTask: selectedIndex == 0 ? false : true);
    _controller.clear();
    Navigator.of(context).pop();
  }

  deleteTask(Task task) async {
    context
        .read<TaskListCubit>()
        .deleteTask(task, isCompletedTask: selectedIndex == 0 ? false : true);
  }
}

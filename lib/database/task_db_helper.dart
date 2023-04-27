import 'package:todoflutter/database/database_helper.dart';

import '../model/task.dart';

class TaskDbHelper {
  Future<List<Task>> getTasks() async {
    var hiveDatabase = await DatabaseHelper.instance.box;
    return hiveDatabase!.values.toList();
  }

  Future<void> addTask(Task task) async {
    var hiveDatabase = await DatabaseHelper.instance.box;
    await hiveDatabase!.add(Task(taskName: task.taskName, completed: false));
  }

  Future<void> removeTask(Task task) async {
    var hiveDatabase = await DatabaseHelper.instance.box;
    final taskToRemove = hiveDatabase?.values
        .firstWhere((element) => element.taskName == task.taskName);
    await taskToRemove?.delete();
  }

  Future<void> updateTask(Task task) async {
    var hiveDatabase = await DatabaseHelper.instance.box;
    final taskToEdit = hiveDatabase?.values
        .firstWhere((element) => element.taskName == task.taskName);
    final index = taskToEdit?.key as int;
    await hiveDatabase!.put(index,
        Task(taskName: task.taskName, completed: !taskToEdit!.completed));
  }
}

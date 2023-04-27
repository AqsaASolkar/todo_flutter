import 'dart:async';

import 'package:todoflutter/database/task_db_helper.dart';

import '../model/task.dart';

abstract class AppRepository {
  Future<List<Task>> getTask();
  Future<void> updateTask(Task task);
  Future<void> removeTask(Task task);
  Future<void> addTask(Task task);
}

class AppRepositoryImpl implements AppRepository {
  TaskDbHelper _dbHelper;

  AppRepositoryImpl(this._dbHelper);

  @override
  Future<List<Task>> getTask({bool force = false}) async {
    return Future.delayed(const Duration(seconds: 2), () {
      return _dbHelper.getTasks();
    });
  }

  @override
  Future<void> updateTask(Task task) async {
    return await _dbHelper.updateTask(task);
  }

  @override
  Future<void> removeTask(Task task) async {
    return await _dbHelper.removeTask(task);
  }

  @override
  Future<void> addTask(Task task) async {
    return await _dbHelper.addTask(task);
  }
}

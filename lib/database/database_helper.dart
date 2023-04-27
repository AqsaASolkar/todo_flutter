import 'package:hive/hive.dart';

import '../model/task.dart';

class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper todoService = DatabaseHelper._internal();
  static DatabaseHelper get instance => todoService;
  Box<Task>? _box;

  Future<Box<Task>?> get box async {
    if (_box != null) {
      return _box;
    } else {
      _box = await Hive.openBox<Task>('mybox');
      return _box;
    }
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class Task extends HiveObject with _$Task {
  Task._(); //Add this line

  @HiveType(typeId: 0)
  factory Task(
      {@HiveField(0) required String taskName,
      @HiveField(1) required bool completed}) = _Task;
}

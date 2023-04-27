import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/task.dart';
part 'task_list_cubit_state.freezed.dart';

@freezed
class TaskListState with _$TaskListState {
  const factory TaskListState.taskLoaded({required List<Task> tasks}) =
      _TaskLoaded;
}

import 'package:todoflutter/pages/task_list_cubit_state.dart';

import '../bloc/base_cubit.dart';
import '../bloc/base_state/base_bloc_state.dart';
import '../datasource/app_repository.dart';
import '../model/task.dart';

class TaskListCubit extends BaseCubit<TaskListState> {
  final AppRepository _repository;

  TaskListCubit(this._repository) : super(const BaseBlocState.init());
  void fetchTasks({bool refresh = false, bool showLoading = true}) async {
    if (showLoading) {
      emit(const BaseBlocState.loading());
    }
    _repository.getTask().then((tasks) {
      emit(BaseBlocState.loaded(TaskListState.taskLoaded(tasks: tasks)));
    }).catchError((error) {
      emit(BaseBlocState.error(error));
    });
  }

  void fetchPendingTasks(
      {bool refresh = false, bool showLoading = true}) async {
    if (showLoading) {
      emit(const BaseBlocState.loading());
    }
    _repository.getPendingTask().then((tasks) {
      emit(BaseBlocState.loaded(TaskListState.taskLoaded(tasks: tasks)));
    }).catchError((error) {
      emit(BaseBlocState.error(error));
    });
  }

  void fetchCompletedTask(
      {bool refresh = false, bool showLoading = true}) async {
    if (showLoading) {
      emit(const BaseBlocState.loading());
    }
    _repository.getCompletedTask().then((tasks) {
      emit(BaseBlocState.loaded(TaskListState.taskLoaded(tasks: tasks)));
    }).catchError((error) {
      emit(BaseBlocState.error(error));
    });
  }

  void addTask(Task task, {bool isCompletedTask = false}) async {
    _repository.addTask(task).then(
        (_) => isCompletedTask ? fetchCompletedTask() : fetchPendingTasks());
  }

  void updateTask(Task task, {bool isCompletedTask = false}) async {
    _repository.updateTask(task).then(
        (_) => isCompletedTask ? fetchCompletedTask() : fetchPendingTasks());
  }

  void deleteTask(Task task, {bool isCompletedTask = false}) async {
    _repository.removeTask(task).then(
        (_) => isCompletedTask ? fetchCompletedTask() : fetchPendingTasks());
  }
}

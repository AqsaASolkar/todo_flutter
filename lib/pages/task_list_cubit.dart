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

  void addTask(Task task) async {
    _repository
        .addTask(task)
        .then((_) => fetchTasks(refresh: false, showLoading: true));
  }

  void updateTask(Task task) async {
    _repository
        .updateTask(task)
        .then((_) => fetchTasks(refresh: false, showLoading: true));
  }

  void deleteTask(Task task) async {
    _repository
        .removeTask(task)
        .then((_) => fetchTasks(refresh: false, showLoading: false));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoflutter/database/task_db_helper.dart';
import 'package:todoflutter/pages/task_list.dart';
import 'package:provider/provider.dart';
import 'package:todoflutter/pages/task_list_cubit.dart';

import 'datasource/app_repository.dart';
import 'model/task.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AppRepository>(
        create: (context) => AppRepositoryImpl(TaskDbHelper()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Consumer<AppRepository>(
            builder: (_, repository, __) => BlocProvider<TaskListCubit>(
              create: (_) => TaskListCubit(repository),
              child: const TaskList(),
            ),
          ),
          theme: ThemeData(primarySwatch: Colors.teal),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projict_3_todo/core/app_routes.dart';
import 'package:projict_3_todo/data/model/task_model.dart';
import 'package:projict_3_todo/data/model/user_model.dart';
import 'package:projict_3_todo/view/screens/add_task_screen.dart';
import 'package:projict_3_todo/view/screens/home_screen.dart' hide TaskModel;
import 'package:projict_3_todo/view/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(StatusTaskAdapter());

  await Hive.openBox<UserModel>('User');
  await Hive.openBox<TaskModel>('Tasks');

  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.profile,
      routes: {
        AppRoutes.profile: (context) => ProfileScreen(),
        AppRoutes.addTask: (context) => AddTaskScreen(),
        AppRoutes.home: (context) => HomeScreen(),
      },
    );
  }
}

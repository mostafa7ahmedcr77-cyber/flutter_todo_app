import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projict_3_todo/core/app_routes.dart';
import 'package:projict_3_todo/data/model/user_model.dart';
import 'package:projict_3_todo/view/screens/add_task_screen.dart';
import 'package:projict_3_todo/view/screens/home_screen.dart';
import 'package:projict_3_todo/view/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.openBox<UserModel>('User');
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.addTask,
      routes: {
        AppRoutes.profile: (context) => ProfileScreen(),
        AppRoutes.addTask: (context) => AddTaskScreen(),
        AppRoutes.home: (context) => HomeScreen(),
      },
    );
  }
}

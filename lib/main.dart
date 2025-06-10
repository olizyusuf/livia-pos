import 'package:flutter/material.dart';
import 'package:liviapos/screen/add_role_screen.dart';
import 'package:liviapos/screen/add_user_screen.dart';
import 'package:liviapos/screen/main_screen.dart';
import 'package:liviapos/screen/role_screen.dart';
import 'package:liviapos/screen/user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Livia Pos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MainScreen(),
      routes: {
        '/main': (context) => const MainScreen(),
        '/users': (context) => const UserScreen(),
        '/add_user': (context) => const AddUserScreen(),
        '/roles': (context) => const RoleScreen(),
        '/add_role': (context) => const AddRoleScreen(),
      },
    );
  }
}

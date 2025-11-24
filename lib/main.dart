import 'package:flutter/material.dart';
import 'package:liviapos/provider/master_provider.dart';
import 'package:liviapos/provider/role_provider.dart';
import 'package:liviapos/provider/user_provider.dart';
import 'package:liviapos/screen/login_screen.dart';
import 'package:liviapos/screen/master_screen.dart';
import 'package:liviapos/screen/role_form_screen.dart';
import 'package:liviapos/screen/user_form_screen.dart';
import 'package:liviapos/screen/main_screen.dart';
import 'package:liviapos/screen/role_screen.dart';
import 'package:liviapos/screen/user_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RoleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MasterProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Livia Pos',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/main': (context) => const MainScreen(),
          '/users': (context) => const UserScreen(),
          '/form_user': (context) => const UserFormScreen(),
          '/roles': (context) => const RoleScreen(),
          '/form_role': (context) => const RoleFormScreen(),
          '/masters': (context) => const MasterScreen(),
        },
      ),
    );
  }
}

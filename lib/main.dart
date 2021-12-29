import 'package:flutter/material.dart';
import 'package:sqflite_student_app/presentation/screens/add_screen.dart';
import 'package:sqflite_student_app/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Students App',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
          ).apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
          ),
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
            color: Colors.yellow,
          ),
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.yellow, fontSize: 25.0)
          ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/add': (context) => const AddScreen(),
      },
    );
  }
}


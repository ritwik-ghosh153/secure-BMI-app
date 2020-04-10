import 'package:crud_app/delete.dart';
import 'package:crud_app/homepage.dart';
import 'package:crud_app/bmi.dart';
import 'package:crud_app/results.dart';
import 'package:crud_app/signin.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp((secureBMI()));
}

class secureBMI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/signup': (context) => SignInPage(),
        '/bmi': (context) => InputPage(),
        '/result': (context) => Results(),
      },
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
    );
  }
}

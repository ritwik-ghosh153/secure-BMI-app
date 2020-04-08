import 'package:crud_app/homepage.dart';
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
        '/signin': (context) => SignInPage(),
      },
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
    );
  }
}

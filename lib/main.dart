import 'package:crud_app/homepage.dart';
import 'package:crud_app/bmi.dart';
import 'package:crud_app/results.dart';
import 'package:crud_app/signin.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp((SecureBMI()));
}

class SecureBMI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///creating routes to navigate between screens
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/signup': (context) => SignInPage(),
        '/bmi': (context) => InputPage(),
        '/result': (context) => Results(),
      },
      ///using  default theme and changing some parameters of it
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
    );
  }
}

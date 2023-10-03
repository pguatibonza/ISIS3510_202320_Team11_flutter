import 'package:flutter/material.dart';
import 'package:tucamion/views/theme/app_theme.dart';
import 'package:tucamion/views/landing.dart';
import 'package:tucamion/views/roles.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: TuCamionTheme.lightTheme(),
      home: const Scaffold(
        body: SingleChildScrollView(
          child: Landing(),
        ),
      ),
    );
  }
}

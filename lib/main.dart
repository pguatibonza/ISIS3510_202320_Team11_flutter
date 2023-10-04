import 'package:flutter/material.dart';
import 'package:tucamion/views/theme/app_theme.dart';
import 'package:tucamion/views/landing.dart';
import 'package:tucamion/controller/TimeController.dart'; // Replace 'path_to_TimeController.dart' with the actual path to the TimeController.dart file.

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements Observer {
  TimeController _timeController = TimeController();
  bool _isDarkMode = TimeController.isDarkModeNow();

  @override
  void initState() {
    super.initState();
    _timeController.addObserver(this);
  }

  @override
  void update() {
    setState(() {
      _isDarkMode = _timeController.isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TuCamion',
      debugShowCheckedModeBanner: false,
      theme:
          _isDarkMode ? TuCamionTheme.darkTheme() : TuCamionTheme.lightTheme(),
      home: const Scaffold(
        body: SingleChildScrollView(
          child: Landing(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timeController.removeObserver(this);
    super.dispose();
  }
}

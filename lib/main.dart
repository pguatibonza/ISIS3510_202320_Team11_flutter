import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tucamion/views/theme/app_theme.dart';
import 'package:tucamion/views/landing.dart';
import 'package:tucamion/controller/TimeController.dart'; // Replace 'path_to_TimeController.dart' with the actual path to the TimeController.dart file.
import 'package:tucamion/controller/dependencyInjection.dart';

void main() {
  runApp(const MyApp());
  DependencyInjection.init();
}

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
    return GetMaterialApp(
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

import 'package:flutter/material.dart';
import 'package:tucamion/home_page.dart';

void main() {
  runApp(const MainApp());
}

class Singleton {
  Singleton._private();

  static final Singleton _instance = Singleton._private();

  factory Singleton() {
    return _instance;
  }
}

class MainApp extends StatelessWidget {
  
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home : HomePage(),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucamion/views/home_page.dart';
import 'package:tucamion/views/homepage_truck.dart';
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
  late Future<Map<String, dynamic>?> userFuture;

  @override
  void initState() {
    super.initState();
    _timeController.addObserver(this);
    userFuture = getUser();
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
      home: Scaffold(
        body: FutureBuilder<Map<String, dynamic>?>(
          future: userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading indicator while waiting for the future to complete
              return CircularProgressIndicator();
            }

            if (snapshot.hasData && snapshot.data != null) {
              final userData = snapshot.data!;
              final userType = userData['userType'];
              final email = userData['email'];

              // Navigate based on userType
              return userType == "LO"
                  ? HomePage(name: email)
                  : HomePageTruck(name: email);
            } else {
              // If snapshot.data is null, return Landing page
              return Landing();
            }
          },
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the JSON string
    String? userJsonString = prefs.getString('user');

    if (userJsonString != null && userJsonString.isNotEmpty) {
      try {
        // Decode the JSON string and return the JSON object
        return jsonDecode(userJsonString);
      } catch (e) {
        // Handle error if JSON decoding fails
        return null;
      }
    } else {
      // Return null if the string is null or empty
      return null;
    }
  }

  @override
  void dispose() {
    _timeController.removeObserver(this);
    super.dispose();
  }
}

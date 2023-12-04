import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucamion/controller/authservices.dart';
import 'package:tucamion/controller/truckservices.dart';
import 'package:tucamion/views/landing.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  

  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
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

class _ProfileState extends State<Profile> {
  final TextEditingController _platesController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _pickupCountryController =
      TextEditingController();
  final TextEditingController _pickupCityController = TextEditingController();
  final TextEditingController _pickupAddressController =
      TextEditingController();
  final TextEditingController _dropoffCountryController =
      TextEditingController();
  final TextEditingController _dropoffCityController = TextEditingController();
  final TextEditingController _dropoffAddressController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Material(
      child: Container(
        width: double.infinity,
        child: Container(
          // edittruckNzW (73:1153)
          padding: EdgeInsets.fromLTRB(16 * fem, 17 * fem, 16 * fem, 15 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder<Map<String, dynamic>?>(
                future: getUser(), // Calling the getUser() method
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while the data is loading
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Display an error message if something goes wrong
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    // Extracting user data from the snapshot
                    final userData = snapshot.data!;
                    final name = userData['name'] ?? 'N/A';
                    final email = userData['email'] ?? 'N/A';
                    final lastName = userData['lastName'] ?? 'N/A';
                    final phone = userData['phone'] ?? 'N/A';
                    final userType = userData['userType'] ?? 'N/A';
                    final id = userData['id']?.toString() ?? 'N/A';

                    // Display user data
                    return Column(
                      children: [
                        Text(
                          'User info',
                          style: GoogleFonts.montserrat(
                            fontSize: 28 * ffem,
                            fontWeight: FontWeight.w800,
                            height: 1.2000000477 * ffem / fem,
                          ),
                        ),
                        SizedBox(height: 16 * fem),
                        Icon(
                          Icons.person_2,
                          color: Colors.grey[500],
                          size: 120,
                        ),
                        SizedBox(height: 16 * fem),
                        Text(
                          (userType == 'LO'
                              ? 'Load Owner'
                              : userType == 'TO'
                                  ? 'Truck Owner'
                                  : 'Driver'),
                          style: GoogleFonts.montserrat(
                            fontSize: 24 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.5 * ffem / fem,
                          ),
                        ),
                        SizedBox(height: 16 * fem),
                        // Displaying user information
                        Text(
                          '$name',
                          style: GoogleFonts.montserrat(
                            fontSize: 18 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * ffem / fem,
                          ),
                        ),
                        Text(
                          '$email',
                          style: GoogleFonts.montserrat(
                            fontSize: 18 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * ffem / fem,
                          ),
                        ),
                        Text(
                          '$phone',
                          style: GoogleFonts.montserrat(
                            fontSize: 18 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.5 * ffem / fem,
                          ),
                        ),
                        SizedBox(height: 24 * fem),
                        TextButton(
                          onPressed: () {
                            logOut();
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: Container(
                            width: 275 * fem,
                            height: 52 * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35 * fem),
                              gradient: LinearGradient(
                                begin: Alignment(1, -0),
                                end: Alignment(-1, 0),
                                colors: <Color>[
                                  Color(0xff2d7eff),
                                  Color(0xff2faaff)
                                ],
                                stops: <double>[0, 1],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Log out',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2175 * ffem / fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Handle the case when there's no data
                    return Text('No user data found');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    bool cleared = await prefs.clear();
    if (cleared) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Landing(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }
}

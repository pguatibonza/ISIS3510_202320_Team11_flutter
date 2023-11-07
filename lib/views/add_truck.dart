import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tucamion/controller/authservices.dart';
import 'package:tucamion/controller/truckservices.dart';

class AddTruck extends StatefulWidget {
  const AddTruck({super.key, required this.name});

  final String name;

  @override
  State<StatefulWidget> createState() {
    return _AddTruckState();
  }
}

class _AddTruckState extends State<AddTruck> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Material(
        child: Container(
          width: double.infinity,
          child: Container(
            // edittruckNzW (73:1153)
            padding:
                EdgeInsets.fromLTRB(16 * fem, 17 * fem, 16 * fem, 15 * fem),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // west6Qi (73:1173)
                  margin:
                      EdgeInsets.fromLTRB(2 * fem, 0 * fem, 0 * fem, 9 * fem),
                  width: 20 * fem,
                  height: 14 * fem,
                  child: Icon(
                    Icons.west,
                    color: Colors.grey[900],
                    size: 24,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Positioned(
                          // frame60YXc (73:1154)
                          left: 0 * fem,
                          top: 0 * fem,
                          child: Container(
                            width: 328 * fem,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // edittruckFS2 (73:1155)
                                  'Add Truck',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 24 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2000000477 * ffem / fem,
                                    color: Color(0xff232323),
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                Container(
                                  // frame37B4n (73:1156)
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // inputhYv (73:1157)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 16 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                          color: Color(0xffefebeb),
                                        ),
                                        child: TextField(
                                          controller: _platesController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                16 * fem,
                                                16 * fem,
                                                16 * fem,
                                                15 * fem),
                                            hintText: 'Plates',
                                            hintStyle: TextStyle(
                                                color: Color(0xff232323)),
                                          ),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // inputbGv (82:1702)
                                        width: double.infinity,
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 16 * fem),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                          color: Color(0xffefebeb),
                                        ),
                                        child: TextField(
                                          controller: _capacityController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                16 * fem,
                                                16 * fem,
                                                16 * fem,
                                                15 * fem),
                                            hintText: 'Capacity (LT)',
                                            hintStyle: TextStyle(
                                                color: Color(0xff232323)),
                                          ),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // inputbGv (82:1702)
                                        width: double.infinity,
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 16 * fem),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                          color: Color(0xffefebeb),
                                        ),
                                        child: TextField(
                                          controller: _pickupCountryController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                16 * fem,
                                                16 * fem,
                                                16 * fem,
                                                15 * fem),
                                            hintText: 'Pick up country',
                                            hintStyle: TextStyle(
                                                color: Color(0xff232323)),
                                          ),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // inputbGv (82:1702)
                                        width: double.infinity,
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 16 * fem),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                          color: Color(0xffefebeb),
                                        ),
                                        child: TextField(
                                          controller: _pickupCityController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                16 * fem,
                                                16 * fem,
                                                16 * fem,
                                                15 * fem),
                                            hintText: 'Pick up city',
                                            hintStyle: TextStyle(
                                                color: Color(0xff232323)),
                                          ),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // inputbGv (82:1702)
                                        width: double.infinity,
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 16 * fem),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                          color: Color(0xffefebeb),
                                        ),
                                        child: TextField(
                                          controller: _pickupAddressController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                16 * fem,
                                                16 * fem,
                                                16 * fem,
                                                15 * fem),
                                            hintText: 'Pick up address',
                                            hintStyle: TextStyle(
                                                color: Color(0xff232323)),
                                          ),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // inputbGv (82:1702)
                                        width: double.infinity,
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 16 * fem),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                          color: Color(0xffefebeb),
                                        ),
                                        child: TextField(
                                          controller: _dropoffCountryController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                16 * fem,
                                                16 * fem,
                                                16 * fem,
                                                15 * fem),
                                            hintText: 'Drop off country',
                                            hintStyle: TextStyle(
                                                color: Color(0xff232323)),
                                          ),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // inputbGv (82:1702)
                                        width: double.infinity,
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 16 * fem),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                          color: Color(0xffefebeb),
                                        ),
                                        child: TextField(
                                          controller: _dropoffCityController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                16 * fem,
                                                16 * fem,
                                                16 * fem,
                                                15 * fem),
                                            hintText: 'Drop off city',
                                            hintStyle: TextStyle(
                                                color: Color(0xff232323)),
                                          ),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // inputbGv (82:1702)
                                        width: double.infinity,
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 16 * fem),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                          color: Color(0xffefebeb),
                                        ),
                                        child: TextField(
                                          controller: _dropoffAddressController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                16 * fem,
                                                16 * fem,
                                                16 * fem,
                                                15 * fem),
                                            hintText: 'Drop off address',
                                            hintStyle: TextStyle(
                                                color: Color(0xff232323)),
                                          ),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2175 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          validateAndSubmitForm(context);
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: Container(
                                          width: 275 * fem,
                                          height: 52 * fem,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(35 * fem),
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
                                              'Save',
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateAndSubmitForm(BuildContext context) async {
    // Check if any of the text fields are empty
    if (_platesController.text.isEmpty ||
        _capacityController.text.isEmpty ||
        _pickupCountryController.text.isEmpty ||
        _pickupCityController.text.isEmpty ||
        _pickupAddressController.text.isEmpty ||
        _dropoffCountryController.text.isEmpty ||
        _dropoffCityController.text.isEmpty ||
        _dropoffAddressController.text.isEmpty) {
      // If any fields are empty, show a popup modal notifying the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Form Incomplete'),
            content: Text('Please fill in all the fields.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
      return; // Stop the function execution here
    }

    // Check internet connectivity
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection, show a popup modal notifying the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Internet Connection'),
            content: Text(
                'You are not connected to the internet. Please try again when you have an internet connection.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
      return; // Stop the function execution here
    }

    // Internet connection available, submit the form
    try {
      TrailerController trailerController = TrailerController();
      AuthService authController = AuthService();
      Map<String, dynamic>? ownerDetails =
          await authController.getUserInfoByEmail(widget.name);
      late int ownerId;
      if (ownerDetails != null) {
        ownerId = ownerDetails['id'];
      }

      // Submit the form data
      await trailerController.createTruck(
        plates: _platesController.text,
        capacity: int.tryParse(_capacityController.text) ?? 0,
        pickup: _pickupCountryController.text,
        dropoff: _dropoffCountryController.text,
        status: 'AV',
        driver: ownerId,
        owner: ownerId,
      );

      // Show the Snackbar with the success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Trailer was created'),
          duration: Duration(seconds: 2),
        ),
      );

      // Pop the current screen after a delay to show the Snackbar
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
    } catch (e) {
      // Handle any errors that occur during submission
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Submission Error'),
            content: Text('There was an error submitting the form: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }
}

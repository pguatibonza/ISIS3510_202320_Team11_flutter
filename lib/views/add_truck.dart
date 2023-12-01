import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tucamion/controller/authservices.dart';
import 'package:tucamion/controller/truckservices.dart';
import 'package:tucamion/views/location_picker.dart';

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

  LatLng? _lastSelectedPickupLocation;
  String _lastSelectedPickupAddress = "";
  LatLng? _lastSelectedDropoffLocation;
  String _lastSelectedDropoffAddress = "";

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Material(
        child: Container(
          width: double.infinity,
          child: Container(
            // edittruckNzW (73:1153)
            padding:
                EdgeInsets.fromLTRB(16 * fem, 17 * fem, 16 * fem, 15 * fem),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          // edittruckFS2 (73:1155)
                          'Add Truck',
                          style: GoogleFonts.montserrat(
                            fontSize: 24 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.2000000477 * ffem / fem,
                          ),
                        ),
                        SizedBox(
                          height: 16 * fem,
                        ),
                        Container(
                          // frame37B4n (73:1156)
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // inputhYv (73:1157)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30 * fem),
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
                                        16 * fem, 16 * fem, 16 * fem, 15 * fem),
                                    hintText: 'Plates',
                                    hintStyle:
                                        TextStyle(color: Color(0xff232323)),
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
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30 * fem),
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
                                        16 * fem, 16 * fem, 16 * fem, 15 * fem),
                                    hintText: 'Capacity (KG)',
                                    hintStyle:
                                        TextStyle(color: Color(0xff232323)),
                                  ),
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2175 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              Text(
                                "Pick up location",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2175 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  showLocationPicker(context,
                                      (LatLng location, String address) {
                                    setState(() {
                                      _lastSelectedPickupLocation = location;
                                      _lastSelectedPickupAddress = address;
                                    });
                                    print(
                                        'Selected location: $location with address: $address');
                                  },
                                      _lastSelectedPickupLocation ??
                                          LatLng(4.60971,
                                              -74.08175)); // Default or last selected location
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _lastSelectedPickupAddress.isNotEmpty
                                              ? _lastSelectedPickupAddress
                                              : 'Bogotá, Colombia', // Default text
                                          style: TextStyle(fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(Icons.search, color: Colors.blue),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Drop off location",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2175 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              InkWell(
                                onTap: () {
                                  showLocationPicker(context,
                                      (LatLng location, String address) {
                                    setState(() {
                                      _lastSelectedDropoffLocation = location;
                                      _lastSelectedDropoffAddress = address;
                                    });
                                    print(
                                        'Selected location: $location with address: $address');
                                  },
                                      _lastSelectedDropoffLocation ??
                                          LatLng(4.60971,
                                              -74.08175)); // Default or last selected location
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _lastSelectedDropoffAddress.isNotEmpty
                                              ? _lastSelectedDropoffAddress
                                              : 'Bogotá, Colombia', // Default text
                                          style: TextStyle(fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(Icons.search, color: Colors.blue),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
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
      ),
    );
  }

  Future<void> showLocationPicker(
      BuildContext context,
      Function(LatLng, String) onLocationSelected,
      LatLng initialLocation) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 1,
          child: LocationPicker(
            onLocationSelected: onLocationSelected,
            initialLocation: initialLocation,
          ),
        );
      },
    );
  }

  void validateAndSubmitForm(BuildContext context) async {
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

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );

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

      if (_lastSelectedPickupLocation == null ||
          _lastSelectedDropoffLocation == null) {
        throw Exception("Pickup and dropoff location can't be blank");
      }

      // Submit the form data
      await trailerController.createTruck(
        plates: _platesController.text,
        capacity: int.tryParse(_capacityController.text) ?? 0,
        pickup:
            "${_lastSelectedPickupLocation!.latitude}, ${_lastSelectedPickupLocation!.longitude}, $_lastSelectedPickupAddress",
        dropoff:
            "${_lastSelectedDropoffLocation!.latitude}, ${_lastSelectedDropoffLocation!.longitude}, $_lastSelectedDropoffAddress",
        status: 'AV',
        driver: ownerId,
        owner: ownerId,
      );

      Navigator.of(context, rootNavigator: true).pop();

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
      print(e);
      // Handle any errors that occur during submission
      Navigator.of(context, rootNavigator: true).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Submission Error'),
            content:
                Text('There was an error submitting the form: ${e.toString()}'),
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

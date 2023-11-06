import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucamion/controller/authservices.dart';
import 'package:tucamion/controller/truckservices.dart';
import 'package:tucamion/models/trailer.dart';

class Trucks extends StatefulWidget {
  const Trucks({super.key, required this.ownerEmail});
  final String ownerEmail;

  @override
  _TrucksState createState() => _TrucksState();
}

class _TrucksState extends State<Trucks> {
  late TrailerController trailerController;
  late AuthService authController;
  List<Trailer> trailers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    trailerController = TrailerController();
    authController = AuthService();
    _initializeData();
  }

  void _initializeData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection
      _loadFromCache();
    } else {
      // Internet connection available
      _fetchDataFromApi();
    }
  }

  void _loadFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString('cachedTrailers');
    if (cachedData != null) {
      List<dynamic> trailersData = json.decode(cachedData);
      setState(() {
        trailers = trailersData.map((data) => Trailer.fromJson(data)).toList();
        isLoading = false;
      });
      _showNoInternetDialog();
    } else {
      setState(() => isLoading = false);
    }
  }

  void _fetchDataFromApi() async {
    if (mounted) setState(() => isLoading = true);

    List<Trailer> loadedTrailers = []; // Declare this outside the try block

    try {
      // Fetch owner's details using their email
      Map<String, dynamic>? ownerDetails =
          await authController.getUserInfoByEmail(widget.ownerEmail);
      if (ownerDetails != null) {
        int ownerId = ownerDetails['id'];
        // Fetch trailers using the owner's ID
        List<dynamic> trailersData =
            await trailerController.getTrailersByOwnerId(ownerId);

        for (var trailerData in trailersData) {
          List<dynamic> tripsData = await trailerController
              .getTripByTrailerIdAndStatus(trailerData['id'], "IP");

          bool isAvailable = true;
          Map<String, dynamic>? loadMap;
          Map<String, dynamic>? pickupAP;
          Map<String, dynamic>? dropoffAP;

          if (tripsData.isNotEmpty) {
            int loadId = int.parse(tripsData[0]['load'].toString());
            loadMap = await trailerController.getLoadById(loadId);
            dropoffAP = await trailerController
                .getAccessPointById(tripsData[0]['dropoff']);
            pickupAP = await trailerController
                .getAccessPointById(tripsData[0]['pickup']);
            isAvailable = false;

            Trailer trailer = Trailer(
                plates: trailerData['plates'],
                capacity: trailerData['capacity'],
                pickup: pickupAP['country'] +
                    " " +
                    pickupAP['city'] +
                    " " +
                    pickupAP['address'] +
                    " | " +
                    pickupAP['before'] +
                    " / " +
                    pickupAP['after'],
                dropoff: dropoffAP['country'] +
                    " " +
                    dropoffAP['city'] +
                    " " +
                    dropoffAP['address'] +
                    " | " +
                    dropoffAP['before'] +
                    " / " +
                    dropoffAP['after'],
                status: trailerData['status'],
                type: trailerData['type'],
                owner: ownerId,
                isAvailable: isAvailable);

            loadedTrailers.add(trailer);
          } else {
            Trailer trailer = Trailer(
                plates: trailerData['plates'],
                capacity: trailerData['capacity'],
                pickup: "Not on service",
                dropoff: "Not on service",
                status: trailerData['status'],
                isAvailable: isAvailable,
                type: trailerData['type'],
                owner: ownerId);
            loadedTrailers.add(trailer);
          }
        }

        if (mounted) {
          setState(() {
            trailers = loadedTrailers;
            isLoading = false;
          });
        }

        _updateCache(
            trailers); // You should cache the final trailers, not the raw data
      } else {
        if (mounted) setState(() => isLoading = false);
      }
    } catch (e) {
      if (mounted) setState(() => isLoading = false);
      // Handle error
      print(e.toString());
    }
  }

  void _updateCache(List<Trailer> trailersData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert each Trailer to a map and encode the entire list
    String encodedData =
        json.encode(trailersData.map((trailer) => trailer.toJson()).toList());
    prefs.setString('cachedTrailers', encodedData);
  }

  void _showNoInternetDialog() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('No Internet Connection'),
            content: Text(
                'Displaying cached data. Please check your internet connection.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Material(
      child: Container(
        width: double.infinity,
        child: Container(
          // trucksYP4 (73:1075)
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // autogrouptue246W (W2kHjjYNdDvSuywkthtuE2)
                padding: EdgeInsets.fromLTRB(
                    16.18 * fem, 0 * fem, 16.18 * fem, 16 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogroupghtyNst (W2kHSVY6tEa96XGio5GHTY)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 16 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            // trucksWz6 (73:1077)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 180 * fem, 0 * fem),
                            child: Text(
                              'Trucks',
                              style: GoogleFonts.montserrat(
                                fontSize: 24 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.2000000477 * ffem / fem,
                                color: Color(0xff232323),
                              ),
                            ),
                          ),
                          Container(
                            // addcircleS74 (73:1078)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 2 * fem),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Container(
                                width: 48 * fem,
                                height: 48 * fem,
                                child: IconButton(
                                  enableFeedback: false,
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.add_circle_rounded,
                                    color: Colors.blue,
                                    size: 48,
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
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: trailers
                              .map((trailer) => TruckCard(
                                  trailer: trailer,
                                  isAvailable: trailer.isAvailable))
                              .toList(),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class TruckCard extends StatelessWidget {
  const TruckCard(
      {super.key, required this.isAvailable, required this.trailer});

  final bool isAvailable;
  final Trailer trailer;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(
            16.01 * fem, 11.75 * fem, 16.15 * fem, 11.57 * fem),
        width: 360.18 * fem,
        height: 199.32 * fem,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffefebeb)),
          color: Color(0xffffffff),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // frame568Xc (73:1081)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
              width: 275 * fem,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // frame55ekr (73:1082)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 15.01 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // chevroletnpr729Zsp (73:1083)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 7.03 * fem),
                          child: Text(
                            trailer.plates,
                            style: GoogleFonts.montserrat(
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.2175 * ffem / fem,
                              color: Color(0xff232323),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // frame53nka (73:1085)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                    width: 270 * fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // frame516WN (73:1086)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0.06 * fem, 15.02 * fem),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // pickupK8E (73:1087)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 6.96 * fem),
                                child: Text(
                                  'Pickup ',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2000000477 * ffem / fem,
                                    color: Color(0xff999999),
                                  ),
                                ),
                              ),
                              Container(
                                // frame61eRQ (73:1088)
                                margin: EdgeInsets.fromLTRB(
                                    0.02 * fem, 0 * fem, 0 * fem, 0 * fem),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // frame63zkA (73:1089)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                      padding: EdgeInsets.fromLTRB(1.75 * fem,
                                          0 * fem, 0 * fem, 0 * fem),
                                      width: double.infinity,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // calendarmonth746 (73:1090)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0.1 * fem, 5.74 * fem, 0 * fem),
                                            width: 10.51 * fem,
                                            height: 11.68 * fem,
                                            child: Icon(
                                              Icons.calendar_month,
                                              color: Colors.grey[900],
                                              size: 14,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                                // notonserviceCbL (73:1091)
                                                trailer.pickup ==
                                                        "Not on service"
                                                    ? "Not on service"
                                                    : trailer.pickup
                                                        .split("|")[1]
                                                        .split("/")[0]
                                                        .split("T")[0],
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 12 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height:
                                                      1.2000000477 * ffem / fem,
                                                  color: Color(0xff232323),
                                                ),
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // frame646wc (73:1092)
                                      margin: EdgeInsets.fromLTRB(0.01 * fem,
                                          0 * fem, 1.99 * fem, 0 * fem),
                                      padding: EdgeInsets.fromLTRB(2.33 * fem,
                                          0 * fem, 0 * fem, 0 * fem),
                                      width: double.infinity,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // locationonDWS (73:1093)
                                            margin: EdgeInsets.fromLTRB(
                                                0 * fem,
                                                0.09 * fem,
                                                4.32 * fem,
                                                0 * fem),
                                            width: 9.34 * fem,
                                            height: 11.49 * fem,
                                            child: Icon(
                                              Icons.location_on,
                                              color: Colors.grey[900],
                                              size: 14,
                                            ),
                                          ),
                                          Text(
                                              // notonservicewSS (73:1094)
                                              trailer.pickup == "Not on service"
                                                  ? "Not on service"
                                                  : trailer.pickup
                                                      .split("|")[0],
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height:
                                                    1.2000000477 * ffem / fem,
                                                color: Color(0xff232323),
                                              ),
                                              overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // frame52VD4 (73:1095)
                          margin: EdgeInsets.fromLTRB(
                              0.06 * fem, 0 * fem, 0 * fem, 0 * fem),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // destinationqXp (73:1096)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 6.98 * fem),
                                child: Text(
                                  'Destination',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2000000477 * ffem / fem,
                                    color: Color(0xff999999),
                                  ),
                                ),
                              ),
                              Container(
                                // frame61TJJ (73:1097)
                                margin: EdgeInsets.fromLTRB(
                                    0.02 * fem, 0 * fem, 0 * fem, 0 * fem),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // frame63zp2 (73:1098)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1 * fem),
                                      padding: EdgeInsets.fromLTRB(1.75 * fem,
                                          0 * fem, 0 * fem, 0 * fem),
                                      width: double.infinity,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // calendarmonthXJA (73:1099)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0.1 * fem, 5.74 * fem, 0 * fem),
                                            width: 10.51 * fem,
                                            height: 11.68 * fem,
                                            child: Icon(
                                              Icons.calendar_month,
                                              color: Colors.grey[900],
                                              size: 14,
                                            ),
                                          ),
                                          Text(
                                            // notonserviceCfC (73:1100)
                                            trailer.pickup == "Not on service"
                                                ? "Not on service"
                                                : trailer.dropoff
                                                    .split("|")[1]
                                                    .split("/")[0]
                                                    .split("T")[0],
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2000000477 * ffem / fem,
                                              color: Color(0xff232323),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // frame647nA (73:1101)
                                      margin: EdgeInsets.fromLTRB(0.01 * fem,
                                          0 * fem, 1.99 * fem, 0 * fem),
                                      padding: EdgeInsets.fromLTRB(2.33 * fem,
                                          0 * fem, 0 * fem, 0 * fem),
                                      width: double.infinity,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // locationonqCN (73:1102)
                                            margin: EdgeInsets.fromLTRB(
                                                0 * fem,
                                                0.09 * fem,
                                                4.32 * fem,
                                                0 * fem),
                                            width: 9.34 * fem,
                                            height: 11.49 * fem,
                                            child: Icon(
                                              Icons.location_on,
                                              color: Colors.grey[900],
                                              size: 14,
                                            ),
                                          ),
                                          Text(
                                              // notonservicewSS (73:1094)
                                              trailer.pickup == "Not on service"
                                                  ? "Not on service"
                                                  : trailer.dropoff
                                                      .split("|")[0],
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height:
                                                    1.2000000477 * ffem / fem,
                                                color: Color(0xff232323),
                                              ),
                                              overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // autogroupi9zcefc (W2kJxXqjqGrhEuS5bCi9Zc)
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0.27 * fem, 0 * fem, 0 * fem),
              width: 51.02 * fem,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  isAvailable
                      ? Container(
                          // frame54nmp (73:1104)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 62.94 * fem),
                          width: double.infinity,
                          height: 18.05 * fem,
                          decoration: BoxDecoration(
                            color: Color(0xffecbc10),
                            borderRadius: BorderRadius.circular(14 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'Available',
                              style: GoogleFonts.montserrat(
                                fontSize: 8 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.2000000477 * ffem / fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          // frame54vwC (73:1130)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 66.94 * fem),
                          width: double.infinity,
                          height: 18.05 * fem,
                          decoration: BoxDecoration(
                            color: Color(0xff8fd270),
                            borderRadius: BorderRadius.circular(14 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'In Transit',
                              style: GoogleFonts.montserrat(
                                fontSize: 8 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.2000000477 * ffem / fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                  Container(
                    // arrowforwardios3Bx (73:1133)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 5.96 * fem, 0 * fem),
                    width: 11.77 * fem,
                    height: 20 * fem,
                    child: IconButton(
                      padding: EdgeInsets.only(right: 20),
                      enableFeedback: false,
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey[900],
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

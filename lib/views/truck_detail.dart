import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tucamion/controller/loadcontroller.dart';
import 'package:tucamion/controller/truckservices.dart';
import 'package:tucamion/controller/usercontroller.dart';
import 'package:tucamion/models/access_point.dart';
import 'package:tucamion/models/load.dart';
import 'package:tucamion/models/trailer.dart';
import 'package:tucamion/models/trip.dart';
import 'package:tucamion/models/user_model.dart';

class TruckDetail extends StatefulWidget {
  const TruckDetail({super.key, required this.trailer});

  final Trailer trailer;

  @override
  _TruckDetailState createState() => _TruckDetailState();
}

class _TruckDetailState extends State<TruckDetail> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Material(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_bus_rounded)),
                Tab(icon: Icon(Icons.location_on)),
                Tab(icon: Icon(Icons.history)),
              ],
            ),
            title: Text(
              'Truck detail',
              style: GoogleFonts.montserrat(
                  fontSize: 24 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.2000000477 * ffem / fem,
                  color: Theme.of(context).textTheme.bodyMedium?.color),
            ),
          ),
          body: TabBarView(
            children: [
              Details(trailer: widget.trailer),
              TruckCurrentTrip(trailer: widget.trailer),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}

class Details extends StatefulWidget {
  const Details({super.key, required this.trailer});

  final Trailer trailer;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Your widgets go here
            Text(
              'Truck detail',
              style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  height: 1.2000000477,
                  color: Theme.of(context).textTheme.bodyMedium?.color),
            ),
            SizedBox(
              height: 60,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Plates: ',
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1.2000000477,
                          color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.trailer.plates,
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          height: 1.2000000477,
                          color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Capacity: ',
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1.2000000477,
                          color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.trailer.capacity.toString() + " KG",
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          height: 1.2000000477,
                          color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Is Available: ',
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1.2000000477,
                          color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.trailer.isAvailable ? "Yes" : "No",
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          height: 1.2000000477,
                          color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                  ],
                ),
              ],
            )
            // Add more widgets as needed
          ],
        ),
      ),
    );
  }
}

class TruckCurrentTrip extends StatefulWidget {
  const TruckCurrentTrip({super.key, required this.trailer});

  final Trailer trailer;

  @override
  _TruckCurrentTripState createState() => _TruckCurrentTripState();
}

class _TruckCurrentTripState extends State<TruckCurrentTrip> {
  final TrailerController _trailerController = TrailerController();
  Trip? _trip;
  User? _loadOwner;
  Load? _load;
  AccessPoint? _pickup;
  AccessPoint? _dropoff;
  late Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = _loadData(); // Call _loadData() once and store its future
  }

  Future<void> _loadData() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // Handle no internet connection
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
    }
    try {
      var response = await _trailerController.getTripByTrailerIdAndStatus(
          widget.trailer.id, "IP");
      if (response is List) {
        List<dynamic> tripList = response;
        if (tripList.isNotEmpty) {
          setState(() {
            _trip = Trip.fromJson(tripList.first);
          });

          // Fetch related data based on foreign keys in _trip
          await _fetchRelatedData();
          print(_load!.type.toString());
        }
      } else {
        throw Exception(
            "Endpoint didn't return a list. It was: " + response.toString());
      }
    } on TimeoutException catch (_) {
      // Handle timeout
      throw Exception(
          "We are having a problem with our services. Try again later.");
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
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

  Future<void> _fetchRelatedData() async {
    if (_trip != null) {
      try {
        // Fetch Load Owner
        var loadOwnerResponse =
            await UserController().getUserById(_trip!.loadOwner);
        setState(() {
          _loadOwner = loadOwnerResponse;
        });

        // Fetch Load
        var loadResponse = await LoadController().getLoadById(_trip!.load);
        if (loadResponse is Map<String, dynamic>) {
          Load load = Load.fromJson(loadResponse);
          setState(() {
            _load = load;
          });
        }

        // Fetch Pickup Access Point
        var pickupResponse =
            await TrailerController().getAccessPointById(_trip!.pickup);
        if (pickupResponse is Map<String, dynamic>) {
          AccessPoint pickup = AccessPoint.fromJson(pickupResponse);
          setState(() {
            _pickup = pickup;
          });
        }

        // Fetch Dropoff Access Point
        var dropoffResponse =
            await TrailerController().getAccessPointById(_trip!.dropoff);
        if (dropoffResponse is Map<String, dynamic>) {
          AccessPoint dropoff = AccessPoint.fromJson(dropoffResponse);
          setState(() {
            _dropoff = dropoff;
          });
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(e.toString()),
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Data loaded, build the actual UI
          return _buildContent();
        }
      },
    );
  }

  Widget _buildContent() {
    return RefreshIndicator(
      onRefresh: () async {
        _loadFuture = _loadData(); // Refresh data
        await _loadFuture;
      },
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          // Your content widgets go here
          // If you have only a few widgets and need to ensure the list covers the screen:
          Container(
            padding: EdgeInsets.only(
              top: 40,
              right: 20,
              left: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Current trip',
                  style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      height: 1.2000000477,
                      color: Theme.of(context).textTheme.bodyMedium?.color),
                ),
                SizedBox(
                  height: 60,
                ),
                _trip == null
                    ? Text(
                        'No trip in progress. Come back later when a trip has started.',
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 1.2000000477,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color),
                        textAlign: TextAlign.center,
                      )
                    : Column(
                        children: [
                          Text(
                            "Pick up and drop off info",
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                height: 1.2000000477,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Pick up location: ${_pickup!.address}, ${_pickup!.city}, ${_pickup!.country}",
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.2000000477,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Pick up time: ${_pickup!.before.toString().split(".")[0]}",
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.2000000477,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Drop off up location: ${_dropoff!.address}, ${_dropoff!.city}, ${_dropoff!.country}",
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.2000000477,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Drop off time: ${_dropoff!.after.toString().split(".")[0]}",
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.2000000477,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Load owner contact info",
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                height: 1.2000000477,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            _loadOwner!.name.toString(),
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.2000000477,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            _loadOwner!.email.toString(),
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.2000000477,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            _loadOwner!.phone.toString(),
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.2000000477,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Load info",
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                height: 1.2000000477,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            _load!.type,
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.2000000477,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${_load!.weight} KG",
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.2000000477,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                // Add more widgets as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}

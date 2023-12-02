import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
              TruckHistory(trailer: widget.trailer),
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
  LatLng? _pickupLatLng;
  LatLng? _dropoffLatLng;

  late Future<void> _loadFuture;

  Future<Location> geocodeLocation(AccessPoint accessPoint) async {
    try {
      List<Location> locations = await locationFromAddress(
          '${accessPoint.address}, ${accessPoint.city}, ${accessPoint.country}');
      if (locations.isNotEmpty) {
        return locations.first;
      } else {
        // Return a default location or throw an error
        throw Exception('No locations found for the given address.');
      }
    } catch (e) {
      print("Geocoding error: $e");
      throw Exception('Failed to geocode location: $e');
    }
  }

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
          if (_pickup != null) {
            var geocodedPickup = await geocodeLocation(_pickup!);
            setState(() {
              _pickupLatLng =
                  LatLng(geocodedPickup.latitude, geocodedPickup.longitude);
            });
          }
        }

        // Fetch Dropoff Access Point
        var dropoffResponse =
            await TrailerController().getAccessPointById(_trip!.dropoff);
        if (dropoffResponse is Map<String, dynamic>) {
          AccessPoint dropoff = AccessPoint.fromJson(dropoffResponse);
          setState(() {
            _dropoff = dropoff;
          });
          if (_dropoff != null) {
            var geocodedDropoff = await geocodeLocation(_dropoff!);
            setState(() {
              _dropoffLatLng =
                  LatLng(geocodedDropoff.latitude, geocodedDropoff.longitude);
            });
          }
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
                  height: 30,
                ),
                _buildMapView(),
                SizedBox(
                  height: 30,
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

  Widget _buildMapView() {
    late GoogleMapController mapController;

    LatLngBounds boundsFromLatLngList(List<LatLng> list) {
      assert(list.isNotEmpty);
      double? x0, x1, y0, y1;
      for (LatLng latLng in list) {
        if (x0 == null) {
          x0 = x1 = latLng.latitude;
          y0 = y1 = latLng.longitude;
        } else {
          if (latLng.latitude > x1!) x1 = latLng.latitude;
          if (latLng.latitude < x0) x0 = latLng.latitude;
          if (latLng.longitude > y1!) y1 = latLng.longitude;
          if (latLng.longitude < y0!) y0 = latLng.longitude;
        }
      }
      return LatLngBounds(
          northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
    }

    void onMapCreated(GoogleMapController controller) {
      mapController = controller;
      if (_pickupLatLng != null && _dropoffLatLng != null) {
        // Calculate bounds
        LatLngBounds bounds =
            boundsFromLatLngList([_pickupLatLng!, _dropoffLatLng!]);

        // Use a delayed Future to ensure the map is rendered
        Future.delayed(Duration(milliseconds: 500), () {
          mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
        });
      }
    }

    Set<Polyline> createRoute() {
      Set<Polyline> route = {};
      if (_pickupLatLng != null && _dropoffLatLng != null) {
        route.add(Polyline(
          polylineId: PolylineId("route"),
          visible: true,
          points: [_pickupLatLng!, _dropoffLatLng!],
          width: 4,
          color: Colors.blue,
        ));
      }
      return route;
    }

    Set<Marker> markers = {};

    if (_pickupLatLng != null && _dropoffLatLng != null) {
      markers.add(Marker(
        markerId: MarkerId("pickup"),
        position: _pickupLatLng!,
        infoWindow: InfoWindow(title: "Pick Up Location"),
      ));
      markers.add(Marker(
        markerId: MarkerId("dropoff"),
        position: _dropoffLatLng!,
        infoWindow: InfoWindow(title: "Drop Off Location"),
      ));
    }

    print(_pickupLatLng);

    return Container(
      height: 300,
      child: GoogleMap(
        polylines: createRoute(),
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _pickupLatLng!, // This will be adjusted shortly
          zoom: 12.0,
        ),
        markers: markers,
      ),
    );
  }
}

class TruckHistory extends StatefulWidget {
  const TruckHistory({super.key, required this.trailer});

  final Trailer trailer;
  @override
  _TruckHistoryState createState() => _TruckHistoryState();
}

class _TruckHistoryState extends State<TruckHistory> {
  final TrailerController _trailerController = TrailerController();
  Future<void>? _loadFuture;
  List<Trip> _trips = [];
  Map<int, AccessPoint> _accessPoints = {};
  Map<int, Load> _loads = {};

  @override
  void initState() {
    super.initState();
    _loadFuture = _loadData();
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

    var tripsResponse = await _trailerController.getTripByTrailerIdAndStatus(
        widget.trailer.id, "DE");
    if (tripsResponse is List) {
      _trips =
          tripsResponse.map((tripJson) => Trip.fromJson(tripJson)).toList();
      await _fetchRelatedData();
    }
  }

  Future<void> _fetchRelatedData() async {
    for (var trip in _trips) {
      var pickupResponse =
          await TrailerController().getAccessPointById(trip.pickup);
      var dropoffResponse =
          await TrailerController().getAccessPointById(trip.dropoff);
      var loadResponse = await LoadController().getLoadById(trip.load);

      if (pickupResponse is Map<String, dynamic>) {
        _accessPoints[trip.pickup] = AccessPoint.fromJson(pickupResponse);
      }
      if (dropoffResponse is Map<String, dynamic>) {
        _accessPoints[trip.dropoff] = AccessPoint.fromJson(dropoffResponse);
      }
      if (loadResponse is Map<String, dynamic>) {
        _loads[trip.load] = Load.fromJson(loadResponse);
      }
    }
  }

  Widget _buildContent() {
    return RefreshIndicator(
      onRefresh: () async {
        _loadFuture = _loadData(); // Refresh data
        await _loadFuture;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0), // Adjust padding as needed
            child: Text(
              'Trip History',
              style: TextStyle(
                fontSize: 24.0, // Adjust font size as needed
                fontWeight: FontWeight.bold,
                // Other text styling as needed
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: _trips.length,
              itemBuilder: (context, index) {
                final trip = _trips[index];
                final pickup = _accessPoints[trip.pickup];
                final dropoff = _accessPoints[trip.dropoff];
                final load = _loads[trip.load];

                if (pickup != null && dropoff != null && load != null) {
                  return TruckHistoryCard(
                    pickup: pickup,
                    dropoff: dropoff,
                    load: load,
                  );
                } else {
                  return Container(); // Placeholder for missing data
                }
              },
            ),
          ),
        ],
      ),
    );
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
          return _buildContent();
        }
      },
    );
  }
}

class TruckHistoryCard extends StatelessWidget {
  const TruckHistoryCard({
    super.key,
    required this.pickup,
    required this.dropoff,
    required this.load,
  });

  final AccessPoint pickup;
  final AccessPoint dropoff;
  final Load load;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      padding: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.fromLTRB(
            16.01 * fem, 11.75 * fem, 16.15 * fem, 11.57 * fem),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 192, 192, 192)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // frame568Xc (73:1081)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
              width: 275 * fem,
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
                        Text(
                          load.type,
                          style: GoogleFonts.montserrat(
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(children: [
                          Icon(
                            Icons.calendar_month,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            size: 14,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "Pick up time: ${pickup.after.toString().split(".")[0]}",
                              style: GoogleFonts.montserrat(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * ffem / fem,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Icon(
                            Icons.calendar_month,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            size: 14,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "Dropoff time: ${dropoff.after.toString().split(".")[0]}",
                              style: GoogleFonts.montserrat(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * ffem / fem,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Icon(
                            Icons.location_on,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            size: 14,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "Pickup location: ${pickup.address}, ${pickup.city}, ${pickup.country}",
                              style: GoogleFonts.montserrat(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * ffem / fem,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Icon(
                            Icons.location_on,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            size: 14,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "Dropoff location: ${dropoff.address}, ${dropoff.city}, ${dropoff.country}",
                              style: GoogleFonts.montserrat(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * ffem / fem,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

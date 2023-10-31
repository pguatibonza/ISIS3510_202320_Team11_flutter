import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tucamion/models/access_point.dart';
import 'package:tucamion/models/load.dart';
import 'package:tucamion/models/trip.dart';
import 'package:geocoding/geocoding.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({super.key,required this.trip,required this.pickup,required this.dropoff,required this.load});
  final Trip trip;
  final AccessPoint pickup;
  final AccessPoint dropoff;
  final Load load;

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  GoogleMapController? _controller;
  LatLng _pickupLocation = LatLng(0.0, 0.0); // Default position
  LatLng _dropoffLocation =LatLng(0.0,0.0);

  @override
  void initState() {
    super.initState();
//    requestLocationPermission
  String pickupAddress="${widget.pickup.address}, ${widget.pickup.city}, ${widget.pickup.country}";
  String dropoffAddress="${widget.dropoff.address}, ${widget.dropoff.city}, ${widget.dropoff.country}";

    getCoordinatesFromAddress(pickupAddress).then((coordinates) {
      setState(() {
        _pickupLocation = coordinates;
      });
    });
    getCoordinatesFromAddress(dropoffAddress).then((coordinates) {
      setState(() {
        _dropoffLocation = coordinates;
      });
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        mapType: MapType.normal, // Set the map type
        initialCameraPosition: CameraPosition(target: _pickupLocation, zoom: 15),
        markers: {
          Marker(
            markerId: MarkerId('Pickup'),
            position: _pickupLocation,
            infoWindow: InfoWindow(title: 'Address Marker'),
          ),
          Marker(
            markerId: MarkerId('Dropoff'),
            position: _dropoffLocation,
            infoWindow: InfoWindow(title: 'Address Marker'),
          ),
        },
      ),

      
    );
  }
}


Future<LatLng> getCoordinatesFromAddress(String address) async {
  bool isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
  print(address);
  try{
  List<Location> locations = await locationFromAddress(address);
  if (locations.isNotEmpty) {
    final location = locations[0];
    print("prrrrrrrrrrrrrrrrrr");
    print(location.latitude);
    return LatLng(location.latitude, location.longitude);
  }
  }
  catch(e){
    print("errrorr $e");
  }
  
  return LatLng(0.0, 0.0); // Default position if address not found
}

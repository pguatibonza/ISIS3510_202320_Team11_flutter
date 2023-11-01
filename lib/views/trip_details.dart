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
  LatLng _bogota=LatLng(4.624335, -74.063644);

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
  appBar: AppBar(title:Text("Trip Info"),),
  body: Stack(
    children: [
      Center(
        child: Container(
          margin: EdgeInsets.all(8),
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: _bogota, zoom: 5),
            markers: {
              Marker(
                markerId: MarkerId('Pickup'),
                position: _pickupLocation,
                infoWindow: InfoWindow(title: 'Pickup Address'),
              ),
              Marker(
                markerId: MarkerId('Dropoff'),
                position: _dropoffLocation,
                infoWindow: InfoWindow(title: 'Dropoff Address'),
              ),
            },
          ),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Load Type: ${widget.load.type}'),
                Text('Trailer Type: ${widget.load.trailerType}'),
                Text('Weight: ${widget.load.weight} lbs'),
                if (widget.load.volume != null)
                  Text('Volume: ${widget.load.volume} cubic ft'),
                Text('Pickup Address: ${widget.pickup.address}, ${widget.pickup.city}, ${widget.pickup.country}'),
                Text('Dropoff Address: ${widget.dropoff.address}, ${widget.dropoff.city}, ${widget.dropoff.country}'),
                if (widget.trip.trailer==null)
                    Text('We have not found a Truck available yet')
                else
                    Text('We have found a truck a truck available'),
              ],
            ),
          ),
        ],
      ),
    ],
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
    print(location.latitude);
    return LatLng(location.latitude, location.longitude);
  }
  }
  catch(e){
    print("Error :  $e");
  }
  
  return LatLng(0.0, 0.0); // Default position if address not found
}

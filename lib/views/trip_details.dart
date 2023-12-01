import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tucamion/controller/api.dart';
import 'package:tucamion/models/access_point.dart';
import 'package:tucamion/models/load.dart';
import 'package:tucamion/models/trip.dart';
import 'package:http/http.dart' as http;

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
     double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;


    return Scaffold(
  appBar: AppBar(title:Text("Trip Info"),),
  body: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Center(
        child: Container(
          height:200,
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
                Text('Load Type: ${widget.load.type}',style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                Text('Trailer Type: ${widget.load.trailerType}',style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                Text('Weight: ${widget.load.weight} lbs',style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                if (widget.load.volume != null)
                  Text('Volume: ${widget.load.volume} cubic ft',style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                Text('Pickup Address: ${widget.pickup.address}, ${widget.pickup.city}, ${widget.pickup.country}',style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                Text('Dropoff Address: ${widget.dropoff.address}, ${widget.dropoff.city}, ${widget.dropoff.country}',style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                if (widget.trip.trailer==null)
                    Text('We have not found a Truck available yet',style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color))
                else
                    Text('We have found a truck available',style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
              ],
            ),
          ),
        ],
      ),
    SizedBox(height: 25*ffem,),
    widget.trip.trailer==null?
    ElevatedButton(
      onPressed: (){
        assignTripToTrailer(widget.trip.id,context);
      },
      style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Background color
                    onPrimary: Colors.white, // Text color
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Asignar camion',
                    style: GoogleFonts.montserrat(
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w600,
                      color: Colors.white, // Text color
                    ),
    )): SizedBox()],
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
Future<void> assignTripToTrailer(int tripId,context) async {
  final String apiUrl = '${api}trips/assignTrailer/$tripId';

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
    );

    if (response.statusCode == 200) {
      print('Trip assigned successfully');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Trip assigned to a trailer'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      print('Failed to assign trip: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed to Assign Trip'),
            content: Text(response.body),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
  } catch (e) {
    print('Error during request: $e');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Error during request: $e'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    
  }
}

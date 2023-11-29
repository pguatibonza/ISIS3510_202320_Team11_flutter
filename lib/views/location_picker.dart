import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationPicker extends StatefulWidget {
  final Function(LatLng, String) onLocationSelected;
  final LatLng initialLocation;

  LocationPicker(
      {required this.onLocationSelected, required this.initialLocation});

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  late GoogleMapController mapController;
  LatLng? _selectedLocation;
  String _address = "";
  String _country = "";
  String _city = "";
  TextEditingController _addressController = TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _searchLocation() async {
    try {
      List<Location> locations =
          await locationFromAddress(_addressController.text);
      if (locations.isNotEmpty) {
        final location = locations.first;
        LatLng newSelectedLocation =
            LatLng(location.latitude, location.longitude);
        _onSelectLocation(newSelectedLocation);
        mapController
            .animateCamera(CameraUpdate.newLatLng(newSelectedLocation));
      }
    } catch (e) {
      // Handle the exception if the address is not found
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An error ocurred'),
            content:
                Text("A network error ocurred trying to lookup the address."),
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
      print("Address not found: $e");
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    _onSelectLocation(LatLng(position.latitude, position.longitude));
    mapController.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
  }

  void _onSelectLocation(LatLng position) async {
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
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      setState(() {
        _selectedLocation = position;
        _address = placemarks.first.street ?? "";
        _city = placemarks.first.locality ?? "";
        _country = placemarks.first.country ?? "";
        _address = placemarks.first.street ?? "";
        _addressController.text =
            _address + ", " + _city + ", " + _country; // Update the text field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _addressController,
                decoration: InputDecoration(
                    hintText: 'Address, City, Country',
                    hintStyle: TextStyle(fontSize: 18)),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: _searchLocation,
            ),
          ],
        ),
        Expanded(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            onTap: _onSelectLocation,
            initialCameraPosition: CameraPosition(
              target: widget.initialLocation, // Use the initialLocation
              zoom: 12.0,
            ),
            markers: _selectedLocation != null
                ? {
                    Marker(
                      markerId: MarkerId('selectedLocation'),
                      position: _selectedLocation!,
                    )
                  }
                : {},
          ),
        ),
        ElevatedButton(
          onPressed: _getCurrentLocation,
          child: Text('Use Current Location'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onLocationSelected(
              _selectedLocation ?? LatLng(0, 0),
              _address + ", " + _city + ", " + _country,
            );
          },
          child: Text('Select this location'),
        ),
      ],
    );
  }
}

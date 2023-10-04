import 'package:location/location.dart';

class LocationController {
  Location location = Location();
  LocationData? currentLocation;

  // Private constructor
  LocationController._privateConstructor();

  // Static instance
  static final LocationController _instance =
      LocationController._privateConstructor();

  // Factory constructor
  factory LocationController() {
    return _instance;
  }

  // Function to fetch the user's location
  Future<void> getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      print("Error fetching location: $e");
    }
  }
}

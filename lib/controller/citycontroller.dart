import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
  // Private constructor
  LocationService._privateConstructor();

  // Static instance
  static final LocationService _instance =
      LocationService._privateConstructor();

  // Factory constructor
  factory LocationService() {
    return _instance;
  }

  Future<String> getCityFromCoordinates(double lat, double lon) async {
    final response = await http.get(
        Uri.parse(
            'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon'),
        headers: {
          'User-Agent':
              'YourAppName' // Replace with your app's name; Nominatim requires a User-Agent header
        });

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['address']['city'] ?? 'City not found';
    } else {
      throw Exception('Failed to load data from Nominatim');
    }
  }
}

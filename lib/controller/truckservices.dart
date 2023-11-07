import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tucamion/controller/api.dart';

class TrailerController {
  // Base URL
  final String baseUrl = api;

  // Get trailers by owner id
  Future<List<dynamic>> getTrailersByOwnerId(int ownerId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/trailers/owner/$ownerId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.isEmpty ? [] : data;
    } else {
      return [];
    }
  }

  // Get trips by trailer id
  Future<List<dynamic>> getTripsByTrailerId(int trailerId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/trips/trailer/$trailerId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.isEmpty ? [] : data;
    } else {
      return [];
    }
  }

  // Get user by id
  Future<Map<String, dynamic>> getUserById(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data.isEmpty ? {} : data;
    } else {
      return {};
    }
  }

  // Get trip by trailer id with specific status
  Future<List<dynamic>> getTripByTrailerIdAndStatus(
      int trailerId, String status) async {
    final response = await http
        .get(Uri.parse('$baseUrl/trips/trailer/$trailerId/status/$status'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      return [];
    }
  }

  // Get accesspoint by id
  Future<Map<String, dynamic>> getAccessPointById(int accessPointId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/accesspoints/$accessPointId'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data.isEmpty ? {} : data;
    } else {
      return {};
    }
  }

  // Get load by id
  Future<Map<String, dynamic>> getLoadById(int loadId) async {
    final response = await http.get(Uri.parse('$baseUrl/loads/$loadId'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data.isEmpty ? {} : data;
    } else {
      return {};
    }
  }

  Future<http.Response> createTruck({
    required String plates,
    required int capacity,
    String? volume,
    required String pickup,
    required String dropoff,
    required String status,
    required int driver,
    required int owner,
  }) async {
    final url = Uri.parse('$baseUrl/trailers');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'plates': plates,
        'capacity': capacity,
        'pickup': pickup,
        'dropoff': dropoff,
        'status': status,
        'type': "AN",
        'driver': null,
        'owner': owner,
      }),
    );

    if (response.statusCode == 201) {
      return response;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load truck data');
    }
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tucamion/controller/api.dart';

class LoadController {
  Future<dynamic> getLoadById(int id) async {
    var url = Uri.parse('$api/loads/$id'); // Replace with your actual API URL

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        // Load found, decode the JSON
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        // Load not found
        return null;
      } else {
        // Other errors
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle any errors here
      throw Exception('Error occurred: $e');
    }
  }
}

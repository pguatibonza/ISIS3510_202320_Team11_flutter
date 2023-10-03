import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tucamion/controller/api.dart';

class AuthService {
  // Singleton pattern setup
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final String baseUrl = api;

  Future<Map<String, dynamic>?> register({
    required String name,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String phone,
    required String userType,
  }) async {
    final response = await http.post(
      Uri.parse("${baseUrl}auth/registration/"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "name": name,
        "lastName": lastName,
        "email": email,
        "password1": password,
        "password2": passwordConfirmation,
        "phone": phone,
        "userType": userType,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      print("Error during registration: ${response.body}");
      return null;
    }
  }

  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("${baseUrl}auth/login/"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error during login: ${response.body}");
      return null;
    }
  }
}
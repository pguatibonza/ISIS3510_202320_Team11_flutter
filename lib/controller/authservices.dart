import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tucamion/controller/api.dart';

class AuthService {
  // Singleton pattern setup
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final String baseUrl = api;

  Future<String> register({
    required String name,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String phone,
    required String userType,
  }) async {
    print(jsonEncode({
      "name": name,
      "lastName": lastName,
      "email": email,
      "password1": password,
      "password2": passwordConfirmation,
      "phone": phone,
      "userType": userType,
    }));

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

    print(response.statusCode);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return 'ok';
    } else {
      return jsonDecode(response.body)['detail'] ?? 'Unknown error occurred.';
    }
  }

  Future<String> login({
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
      return 'ok';
    } else {
      return jsonDecode(response.body)['detail'] ?? 'Incorrect credentials.';
    }
  }
}

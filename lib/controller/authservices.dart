import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tucamion/controller/api.dart';

class AuthService {
  // Singleton pattern setup
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final String baseUrl = api;
  final String baseUrl2 = api2;

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
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      List<String> errorMessages = [];

      responseBody.forEach((key, value) {
        if (value is List) {
          errorMessages.add(value.join(', '));
        } else {
          errorMessages.add(value.toString());
        }
      });
      return errorMessages.join('; ');
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
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      List<String> errorMessages = [];

      responseBody.forEach((key, value) {
        if (value is List) {
          errorMessages.add(value.join(', '));
        } else {
          errorMessages.add(value.toString());
        }
      });
      return errorMessages.join('; ');
    }
  }

  Future<Map<String, dynamic>?> getUserInfoByEmail(String email) async {
    final response = await http.get(
      Uri.parse("${baseUrl}users/email/$email"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print('Failed to load user info: ${response.statusCode}');
      return null;
    }
  }

  Future<String?> getUserTypeByEmail(String email) async {
    final userInfo = await getUserInfoByEmail(email);
    if (userInfo != null && userInfo.containsKey('userType')) {
      return userInfo['userType'];
    } else {
      print('Failed to get userType or userType not found');
      return null;
    }
  }

  Future<String?> getNameByEmail(String email) async {
    final userInfo = await getUserInfoByEmail(email);
    if (userInfo != null && userInfo.containsKey('name')) {
      return userInfo['name'];
    } else {
      print('Failed to get name or name not found');
      return null;
    }
  }
}

// controller/user_controller.dart

import 'package:tucamion/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './authservices.dart';
import './api.dart';
class UserController {
  // Singleton pattern setup
  static final UserController _instance = UserController._internal();
  factory UserController() => _instance;
  static User savedUser=User();
  UserController._internal();

  final AuthService _authService = AuthService();
  


  Future<String> authenticate(String email, String password) async {
    final responseMessage =
        await _authService.login(email: email, password: password);
    
    return responseMessage;
  }

  Future<String> register({
    required String name,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String phone,
    required String userType,
  }) async {
    final responseMessage = await _authService.register(
      name: name,
      lastName: lastName,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      phone: phone,
      userType: userType,
    );

    return responseMessage;
  }

 void SaveUser(String email) async {
  final response = await http.get(Uri.parse('$users/email/$email'));

  if (response.statusCode == 200) {
    final userMap = json.decode(response.body);
    savedUser=User.fromJson(userMap);
  } else {
    throw Exception('Failed to load user');
  }
}
}

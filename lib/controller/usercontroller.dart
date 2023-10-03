// controller/user_controller.dart

import './authservices.dart';

class UserController {
  // Singleton pattern setup
  static final UserController _instance = UserController._internal();
  factory UserController() => _instance;
  UserController._internal();

  final AuthService _authService = AuthService();

  Future<bool> authenticate(String email, String password) async {
    final response = await _authService.login(email: email, password: password);
    if (response != null && response.containsKey('key')) {
      return true;
    }
    return false;
  }

  Future<bool> register({
    required String name,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String phone,
    required String userType,
  }) async {
    final response = await _authService.register(
      name: name,
      lastName: lastName,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      phone: phone,
      userType: userType,
    );

    if (response != null && response.containsKey('key')) {
      return true;
    }
    return false;
  }
}

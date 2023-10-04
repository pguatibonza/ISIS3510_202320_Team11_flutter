// controller/user_controller.dart

import './authservices.dart';

class UserController {
  // Singleton pattern setup
  static final UserController _instance = UserController._internal();
  factory UserController() => _instance;
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
}

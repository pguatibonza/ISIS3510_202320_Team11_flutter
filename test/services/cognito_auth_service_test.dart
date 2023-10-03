import 'package:flutter_test/flutter_test.dart';
import 'package:tucamion/api/cognitoauthservices.dart';

void main() {
  final authService = CognitoAuthService();

  group('CognitoAuthService Test', () {
    // Testing the singleton property
    test('Test singleton property', () {
      final anotherAuthServiceInstance = CognitoAuthService();
      expect(identical(authService, anotherAuthServiceInstance), true);
    });

    // Testing the registration functionality - This will actually attempt to register a user.
    // You may want to delete or comment out this test unless you want to perform actual registration during testing.

    test('Test register user', () async {
      final session = await authService.registerUser(
          'danielintel@hotmail.com', 'TestPassword001');
      expect(session, isNotNull);
    });

    test('Test confirmate registration', () async {
      final session = await authService.confirmRegistration(
          'danielintel@hotmail.com', '395431');
      expect(session, isNotNull);
    });

    test('Test authenticate user', () async {
      final session = await authService.authenticateUser(
          'danielintel@hotmail.com', 'TestPassword001');
      expect(session, isNotNull);
    });

    // Testing the authentication functionality - This will actually attempt to authenticate a user.
  });
}

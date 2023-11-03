import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:tucamion/controller/authservices.dart';

void main() {
  final authService =
      AuthService(); // Adjust if your AuthService constructor is different
  test('getUserInfoByEmail returns correct user info for given email',
      () async {
    final userInfo =
        await authService.getUserInfoByEmail("danielintel@hotmail.com");
    print(userInfo);
    expect(userInfo, isA<Map<String, dynamic>>());
  });

  // Test getUserTypeByEmail
  test('getUserTypeByEmail returns correct userType for given email', () async {
    final userType =
        await authService.getUserTypeByEmail("danielintel@hotmail.com");
    expect(userType, 'LO');
  });

  // Test getNameByEmail
  test('getNameByEmail returns correct name for given email', () async {
    final name = await authService.getNameByEmail("danielintel@hotmail.com");
    expect(name, 'Daniel Reyes');
  });
}

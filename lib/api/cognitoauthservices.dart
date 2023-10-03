import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class CognitoAuthService {
  static final CognitoAuthService _instance = CognitoAuthService._internal();
  factory CognitoAuthService() => _instance;

  final userPool = CognitoUserPool(
    'us-east-1_pHO5SVYRt',
    '6ml5vgvppd5v0jft6v3s4bjh34',
  );

  CognitoAuthService._internal();

  Future<CognitoUserSession?> registerUser(
      String email, String password) async {
    try {
      await userPool.signUp(email, password);
      final cognitoUser = CognitoUser(email, userPool);
      final authDetails =
          AuthenticationDetails(username: email, password: password);
      final session = await cognitoUser.authenticateUser(authDetails);
      return session;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> confirmRegistration(
      String email, String confirmationCode) async {
    final cognitoUser = CognitoUser(email, userPool);
    bool registrationConfirmed = false;
    try {
      registrationConfirmed =
          await cognitoUser.confirmRegistration(confirmationCode);
    } catch (e) {
      print(e);
    }
    return registrationConfirmed;
  }

  Future<CognitoUserSession?> authenticateUser(
      String email, String password) async {
    final cognitoUser = CognitoUser(email, userPool);
    final authDetails =
        AuthenticationDetails(username: email, password: password);
    try {
      final session = await cognitoUser.authenticateUser(authDetails);
      return session;
    } on CognitoUserNewPasswordRequiredException catch (e) {
      print(e);
    } on CognitoUserMfaRequiredException catch (e) {
      print(e);
    } on CognitoUserSelectMfaTypeException catch (e) {
      print(e);
    } on CognitoUserMfaSetupException catch (e) {
      print(e);
    } on CognitoUserTotpRequiredException catch (e) {
      print(e);
    } on CognitoUserCustomChallengeException catch (e) {
      print(e);
    } on CognitoUserConfirmationNecessaryException catch (e) {
      print(e);
    } on CognitoClientException catch (e) {
      print(e);
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }
}

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tucamion/controller/authservices.dart';
import 'package:tucamion/controller/connectivityController.dart';
import 'package:tucamion/views/CustomAlertDialog.dart';
import 'package:tucamion/views/homepage_truck.dart';
import 'package:tucamion/views/roles.dart';
import 'package:tucamion/views/home_page.dart';
import 'package:tucamion/views/theme/app_colors.dart';
import 'package:tucamion/controller/usercontroller.dart';

import 'homepage_driver.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() {
    return _LogInState();
  }
}

class _LogInState extends State<LogIn> {
  final UserController _userController = UserController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Material(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Container(
          // loginZVR (17:588)
          padding:
              EdgeInsets.fromLTRB(37 * fem, 143 * fem, 38 * fem, 123 * fem),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // welcomebackGud (17:592)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 32 * fem),
                child: Text(
                  'Welcome Back!',
                  style: GoogleFonts.montserrat(
                    fontSize: 24 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.2000000477 * ffem / fem,
                  ),
                ),
              ),
              Container(
                // frame379iX (17:589)
                margin:
                    EdgeInsets.fromLTRB(3 * fem, 0 * fem, 7 * fem, 29 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // inputseX (17:590)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 16 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30 * fem),
                        color: const Color(0xffefebeb),
                      ),
                      child: TextField(
                        controller: _emailController,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(
                              15.5 * fem, 17.5 * fem, 15.5 * fem, 17.5 * fem),
                          hintText: 'Email',
                          hintStyle: const TextStyle(color: Color(0xff444444)),
                        ),
                        style: GoogleFonts.montserrat(
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2000000817 * ffem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                    Container(
                      // inputiQF (17:591)
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30 * fem),
                        color: const Color(0xffefebeb),
                      ),
                      child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(
                              16 * fem, 16 * fem, 16 * fem, 16 * fem),
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Color(0xff444444)),
                        ),
                        style: GoogleFonts.montserrat(
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2000000817 * ffem / fem,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(_errorMessage!,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: error, fontSize: 16)),
                      ),
                  ],
                ),
              ),
              Container(
                // frame339VZ (17:593)
                margin:
                    EdgeInsets.fromLTRB(3 * fem, 0 * fem, 7 * fem, 50 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // frame3369u (17:594)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 16 * fem),
                      child: TextButton(
                        onPressed: _login,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 49 * fem,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35 * fem),
                            gradient: const LinearGradient(
                              begin: Alignment(1, -0),
                              end: Alignment(-1, 0),
                              colors: <Color>[
                                Color(0xff2d7eff),
                                Color(0xff2faaff),
                                Color(0xff2faaff)
                              ],
                              stops: <double>[0, 1, 1],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Log In',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.2175 * ffem / fem,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // line10Q47 (17:596)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 15 * fem),
                width: double.infinity,
                height: 1 * fem,
                decoration: const BoxDecoration(
                  color: Color(0xffd9d9d9),
                ),
              ),
              Container(
                // donthaveanaccountsignup8ko (17:597)
                margin: EdgeInsets.fromLTRB(2 * fem, 0 * fem, 0 * fem, 0 * fem),
                child: TextButton(
                  onPressed: () {
                    if (ConnectivityController.hasInternet) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Roles()),
                      );
                    } else {
                      CustomAlertDialog.showAlertDialog(context);
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.montserrat(
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2189999989 * ffem / fem,
                          color: Theme.of(context).textTheme.bodyMedium?.color),
                      children: [
                        TextSpan(
                          text: 'Don\'t ',
                          style: GoogleFonts.montserrat(
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.2175 * ffem / fem,
                          ),
                        ),
                        TextSpan(
                          text: 'have',
                          style: GoogleFonts.montserrat(
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.2175 * ffem / fem,
                          ),
                        ),
                        TextSpan(
                          text: ' an account?',
                          style: GoogleFonts.montserrat(
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.2175 * ffem / fem,
                          ),
                        ),
                        TextSpan(
                          text: ' ',
                          style: GoogleFonts.montserrat(
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.2175 * ffem / fem,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: GoogleFonts.montserrat(
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.2175 * ffem / fem,
                            color: const Color(0xff2e85ff),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _login() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection, show a popup modal notifying the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Internet Connection'),
            content: Text(
                'You are not connected to the internet. Please try again when you have an internet connection.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
      return; // Stop the function execution here
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );

    try {
      String email = _emailController.text;
      String password = _passwordController.text;

      String result = await _userController
          .authenticate(email, password)
          .timeout(Duration(seconds: 10));
      final authService = AuthService();

      if (result == "ok") {
        // ignore: use_build_context_synchronously
        _userController.SaveUser(email);
        final userType = await authService.getUserTypeByEmail(email);
        final userInfo = await authService.getNameByEmail(email);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            if (userType == "LO") {
              return HomePage(name: email);
            } else if (userType == "DR") {
              return HomePageDriver(name: email);
            } else {
              return HomePageTruck(name: email);
            }
          }),
          (Route<dynamic> route) => false,
        );
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        setState(() {
          _errorMessage = result;
        });
      }
    } on TimeoutException catch (_) {
      Navigator.of(context, rootNavigator: true).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content:
                Text('Something went wrong with our services. Try again later'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
      return;
    } catch (e) {
      // Handle other exceptions
      // You can show another dialog or handle the exception as needed
    }
  }
}

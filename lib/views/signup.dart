import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tucamion/controller/connectivityController.dart';
import 'package:tucamion/views/CustomAlertDialog.dart';
import 'package:tucamion/views/homepage_truck.dart';
import 'package:tucamion/views/login.dart';
import 'package:tucamion/views/home_page.dart';
import 'package:tucamion/controller/usercontroller.dart';
import 'package:tucamion/views/theme/app_colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.role});
  final String role;

  @override
  State<SignUp> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final UserController _userController = UserController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
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
          // signinCNb (17:598)
          padding: EdgeInsets.fromLTRB(40 * fem, 72 * fem, 45 * fem, 77 * fem),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // createanaccountKi7 (17:599)
                margin:
                    EdgeInsets.fromLTRB(3 * fem, 0 * fem, 0 * fem, 32 * fem),
                child: Text(
                  'Create an account',
                  style: GoogleFonts.montserrat(
                    fontSize: 24 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.2000000477 * ffem / fem,
                  ),
                ),
              ),
              SizedBox(
                // frame38dio (17:600)
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // frame37atw (17:601)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 32 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // inputrrT (17:602)
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30 * fem),
                              color: const Color(0xffefebeb),
                            ),
                            child: TextField(
                              controller: _nameController,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.fromLTRB(
                                    16 * fem, 17.5 * fem, 16 * fem, 16.5 * fem),
                                hintText: 'Name',
                                hintStyle:
                                    const TextStyle(color: Color(0xff444444)),
                              ),
                              style: GoogleFonts.montserrat(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16 * fem,
                          ),
                          Container(
                            // inputi7y (17:603)
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
                                    15.5 * fem, 16 * fem, 15.5 * fem, 15 * fem),
                                hintText: 'Email',
                                hintStyle:
                                    const TextStyle(color: Color(0xff444444)),
                              ),
                              style: GoogleFonts.montserrat(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16 * fem,
                          ),
                          Container(
                            // inputC39 (17:604)
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30 * fem),
                              color: const Color(0xffefebeb),
                            ),
                            child: TextField(
                              controller: _phoneController,
                              maxLines: null,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.fromLTRB(
                                    16 * fem, 16 * fem, 16 * fem, 15 * fem),
                                hintText: 'Phone number',
                                hintStyle:
                                    const TextStyle(color: Color(0xff444444)),
                              ),
                              style: GoogleFonts.montserrat(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16 * fem,
                          ),
                          Container(
                            // inputevj (17:605)
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30 * fem),
                              color: const Color(0xffefebeb),
                            ),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              maxLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.fromLTRB(
                                    16 * fem, 16 * fem, 16 * fem, 15 * fem),
                                hintText: 'Password',
                                hintStyle:
                                    const TextStyle(color: Color(0xff444444)),
                              ),
                              style: GoogleFonts.montserrat(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16 * fem,
                          ),
                          Container(
                            // inputWi3 (17:606)
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30 * fem),
                              color: const Color(0xffefebeb),
                            ),
                            child: TextField(
                              controller: _passwordConfirmController,
                              maxLines: 1,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.fromLTRB(
                                    16 * fem, 16 * fem, 16 * fem, 15 * fem),
                                hintText: 'Confirm password',
                                hintStyle:
                                    const TextStyle(color: Color(0xff444444)),
                              ),
                              style: GoogleFonts.montserrat(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2175 * ffem / fem,
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
                                      .copyWith(color: error)),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: _signUp,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              // frame33JP1 (17:608)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 0 * fem),
                              width: double.infinity,
                              height: 52 * fem,
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
                                  'Sign up',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2175 * ffem / fem,
                                    color: const Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            // alreadyhaveanaccountsigninihd (17:609)
                            onPressed: () {
                              if (ConnectivityController.hasInternet) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LogIn()),
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
                                    fontWeight: FontWeight.w700,
                                    height: 1.2189999989 * ffem / fem,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color),
                                children: [
                                  TextSpan(
                                    text: 'Already have an account?',
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
                                      fontWeight: FontWeight.w700,
                                      height: 1.2175 * ffem / fem,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Log In',
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signUp() async {
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
      String name = _nameController.text;
      String email = _emailController.text;
      String phone = _phoneController.text;
      String password = _passwordController.text;
      String confirmPassword = _passwordConfirmController.text;

      String result = await _userController
          .register(
            name: name,
            lastName: ".",
            email: email,
            password: password,
            passwordConfirmation: confirmPassword,
            phone: phone,
            userType: widget.role,
          )
          .timeout(Duration(seconds: 10));

      if (result == "ok") {
        // ignore: use_build_context_synchronousl
        _userController.SaveUser(email);
        if (widget.role == "LO") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomePage(
                name: email,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomePageTruck(
                name: email,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        }
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

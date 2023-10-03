import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tucamion/views/login.dart';
import 'package:tucamion/controller/usercontroller.dart';
import 'package:tucamion/views/theme/app_colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required String role});

  @override
  State<SignUp> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
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
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
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
                    color: const Color(0xff232323),
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
                              keyboardType: TextInputType.phone,
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
                            onPressed: () async {
                              bool success = await UserController().register(
                                  _emailController.text,
                                  _nameController.text,
                                  _phoneController.text,
                                  _passwordController.text,
                                  _passwordConfirmController.text);
                              if (success) {
                                print("Sign up successful");
                              } else {
                                setState(() {
                                  _errorMessage =
                                      "Both password must be the same";
                                });
                              }
                            },
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogIn()),
                              );
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
                                  color: const Color(0xff232323),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Already have an account?',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2175 * ffem / fem,
                                      color: const Color(0xff232323),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2175 * ffem / fem,
                                      color: const Color(0xff232323),
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
}

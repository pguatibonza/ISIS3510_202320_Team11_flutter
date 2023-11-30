import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tucamion/controller/connectivityController.dart';
import 'package:tucamion/views/CustomAlertDialog.dart';
import 'package:tucamion/views/signup.dart';

class Roles extends StatelessWidget {
  const Roles({super.key});

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
          // signinkSs (17:610)
          padding: EdgeInsets.fromLTRB(16 * fem, 80 * fem, 16 * fem, 294 * fem),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // whatwouldyouliketodoGg7 (17:611)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 24 * fem),
                child: Text(
                  'What would you like to do?',
                  style: GoogleFonts.montserrat(
                      fontSize: 18 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2000000212 * ffem / fem,
                      color: Theme.of(context).textTheme.bodyMedium?.color),
                ),
              ),
              SizedBox(
                // frame47xoq (17:612)
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      // frame48WqM (17:613)
                      onPressed: () {
                        if (ConnectivityController.hasInternet) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp(
                                      role: 'LO',
                                    )),
                          );
                        } else {
                          CustomAlertDialog.showAlertDialog(context);
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            16 * fem, 16 * fem, 21 * fem, 16 * fem),
                        width: double.infinity,
                        height: 80 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6 * fem),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x19000000),
                              offset: Offset(0 * fem, 1 * fem),
                              blurRadius: 4 * fem,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // package1Af1 (17:614)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 16 * fem, 0 * fem),
                              width: 48 * fem,
                              height: 48 * fem,
                              child: Image.asset(
                                'assets/images/package-1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              // frame46tb1 (17:615)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 6 * fem, 0 * fem, 6 * fem),
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // sendpackagescmu (17:616)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 3 * fem),
                                    child: Text(
                                      'Send packages',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2175 * ffem / fem,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.color),
                                    ),
                                  ),
                                  Text(
                                    // getyourloadsdeliveredbyourtruc (17:617)
                                    'Get your loads delivered by our trucks',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2000000477 * ffem / fem,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10 * fem,
                    ),
                    TextButton(
                      // frame45dwu (17:618)
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            16 * fem, 16 * fem, 89 * fem, 16 * fem),
                        width: double.infinity,
                        height: 80 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6 * fem),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x19000000),
                              offset: Offset(0 * fem, 1 * fem),
                              blurRadius: 4 * fem,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // driver1WF1 (17:619)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 16 * fem, 0 * fem),
                              width: 48 * fem,
                              height: 48 * fem,
                              child: Image.asset(
                                'assets/images/driver-1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              // frame46SPZ (17:620)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 6 * fem, 0 * fem, 6 * fem),
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // earnbydeliveringnTR (17:621)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 3 * fem),
                                    child: Text(
                                      'Earn by delivering',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2175 * ffem / fem,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.color),
                                    ),
                                  ),
                                  Text(
                                    // becomeoneofourdrivershaP (17:622)
                                    'Become one of our drivers',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2000000477 * ffem / fem,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10 * fem,
                    ),
                    TextButton(
                      // frame47p9D (17:623)
                      onPressed: () {
                        if (ConnectivityController.hasInternet) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp(
                                      role: 'TO',
                                    )),
                          );
                        } else {
                          CustomAlertDialog.showAlertDialog(context);
                        }
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            16 * fem, 16 * fem, 29 * fem, 16 * fem),
                        width: double.infinity,
                        height: 80 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6 * fem),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x19000000),
                              offset: Offset(0 * fem, 1 * fem),
                              blurRadius: 4 * fem,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // deliverytruck1UUf (17:624)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 16 * fem, 0 * fem),
                              width: 48 * fem,
                              height: 48 * fem,
                              child: Image.asset(
                                'assets/images/delivery-truck-1.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              // frame46o19 (17:625)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 6 * fem, 0 * fem, 6 * fem),
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // rentyourtruckXhq (17:626)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 3 * fem),
                                    child: Text(
                                      'Rent your truck',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2175 * ffem / fem,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.color),
                                    ),
                                  ),
                                  Text(
                                    // earnbylettingsomeoneelsedrivei (17:627)
                                    'Earn by letting someone else drive it',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2000000477 * ffem / fem,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color),
                                  ),
                                ],
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
      ),
    );
  }
}

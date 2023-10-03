import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Container(
        // landingPsD (17:577)
        padding: EdgeInsets.fromLTRB(38 * fem, 116 * fem, 38 * fem, 73 * fem),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // tucamionh7D (17:578)
              margin: EdgeInsets.fromLTRB(4 * fem, 0 * fem, 0 * fem, 23 * fem),
              child: Text(
                'TuCamion',
                style: GoogleFonts.montserrat(
                  fontSize: 24 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.2175 * ffem / fem,
                  letterSpacing: 2.88 * fem,
                  color: Color(0xff424242),
                ),
              ),
            ),
            Container(
              // group8zc7 (17:583)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 24 * fem),
              width: double.infinity,
              height: 212 * fem,
              child: Stack(
                children: [
                  Positioned(
                    // deliverytruck1KuH (17:584)
                    left: 78 * fem,
                    top: 85 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 127 * fem,
                        height: 127 * fem,
                        child: Image.asset(
                          'assets/images/delivery-truck-1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // rectangle14df5 (17:585)
                    left: 15 * fem,
                    top: 194 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 258 * fem,
                        height: 3 * fem,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xff2c3d49),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // cloudy1A9D (17:586)
                    left: 0 * fem,
                    top: 0 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 96 * fem,
                        height: 96 * fem,
                        child: Image.asset(
                          'assets/images/cloudy-1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // cloudy2rnj (17:587)
                    left: 230 * fem,
                    top: 76 * fem,
                    child: Align(
                      child: SizedBox(
                        width: 54 * fem,
                        height: 54 * fem,
                        child: Image.asset(
                          'assets/images/cloudy-2.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // effortlesspackagedeliveriesaty (17:579)
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 1 * fem, 48 * fem),
              constraints: BoxConstraints(
                maxWidth: 216 * fem,
              ),
              child: Text(
                'Effortless package deliveries at your fingertips',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 14 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.2000000817 * ffem / fem,
                  color: const Color(0xff232323),
                ),
              ),
            ),
            Container(
              // frame33cvK (17:580)
              margin: EdgeInsets.fromLTRB(4 * fem, 0 * fem, 5 * fem, 0 * fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // frame33LLX (17:581)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 16 * fem),
                    child: TextButton(
                      onPressed: () {},
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
                              Color(0xff2faaff)
                            ],
                            stops: <double>[0, 1],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Log in',
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
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.montserrat(
                          fontSize: 12 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2000000477 * ffem / fem,
                          color: const Color(0xff232323),
                        ),
                        children: [
                          TextSpan(
                            text: 'Don\'t ',
                            style: GoogleFonts.montserrat(
                              fontSize: 12 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.2000000477 * ffem / fem,
                              color: const Color(0xff232323),
                            ),
                          ),
                          TextSpan(
                            text: 'have',
                            style: GoogleFonts.montserrat(
                              fontSize: 12 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.2000000477 * ffem / fem,
                              color: const Color(0xff232323),
                            ),
                          ),
                          TextSpan(
                            text: ' an account? ',
                            style: GoogleFonts.montserrat(
                              fontSize: 12 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.2000000477 * ffem / fem,
                              color: const Color(0xff232323),
                            ),
                          ),
                          TextSpan(
                            text: 'Sign up',
                            style: GoogleFonts.montserrat(
                              fontSize: 12 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.2000000477 * ffem / fem,
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
    );
  }
}

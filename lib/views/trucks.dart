import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class Trucks extends StatefulWidget {
  const Trucks({super.key});

  @override
  _TrucksState createState() => _TrucksState();
}

class _TrucksState extends State<Trucks> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360.3596191406;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // trucksYP4 (73:1075)
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogrouptue246W (W2kHjjYNdDvSuywkthtuE2)
              padding: EdgeInsets.fromLTRB(
                  16.18 * fem, 16 * fem, 16.18 * fem, 16 * fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroupghtyNst (W2kHSVY6tEa96XGio5GHTY)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 16 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // trucksWz6 (73:1077)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 198 * fem, 0 * fem),
                          child: Text(
                            'Trucks',
                            style: GoogleFonts.montserrat(
                              fontSize: 24 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.2000000477 * ffem / fem,
                              color: Color(0xff232323),
                            ),
                          ),
                        ),
                        Container(
                          // addcircleS74 (73:1078)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 2 * fem),
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              width: 48 * fem,
                              height: 48 * fem,
                              child: Image.asset(
                                'assets/v3/images/addcircle-i9g.png',
                                width: 48 * fem,
                                height: 48 * fem,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // input6Bc (73:1134)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 4 * fem, 0 * fem),
                    width: 324 * fem,
                    height: 49 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30 * fem),
                      color: Color(0xffefebeb),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(
                            16 * fem, 12 * fem, 16 * fem, 13 * fem),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // frame71a6n (73:1079)
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 26.68 * fem),
              width: double.infinity,
              height: 404.32 * fem,
              child: Stack(
                children: [
                  Positioned(
                    // frame576L2 (73:1080)
                    left: 0 * fem,
                    top: 0 * fem,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            16.01 * fem, 11.75 * fem, 16.15 * fem, 11.57 * fem),
                        width: 360.18 * fem,
                        height: 199.32 * fem,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffefebeb)),
                          color: Color(0xffffffff),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // frame568Xc (73:1081)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 147 * fem, 0 * fem),
                              width: 130 * fem,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // frame55ekr (73:1082)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 15.01 * fem),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // chevroletnpr729Zsp (73:1083)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 7.03 * fem),
                                          child: Text(
                                            'Chevrolet Npr 729',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14 * ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.2175 * ffem / fem,
                                              color: Color(0xff232323),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // jahelprezs7p (73:1084)
                                          margin: EdgeInsets.fromLTRB(
                                              0.02 * fem,
                                              0 * fem,
                                              0 * fem,
                                              0 * fem),
                                          child: Text(
                                            'Jahel Pérez',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2000000477 * ffem / fem,
                                              color: Color(0xff232323),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // frame53nka (73:1085)
                                    margin: EdgeInsets.fromLTRB(
                                        0.05 * fem, 0 * fem, 0 * fem, 0 * fem),
                                    width: 104.08 * fem,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // frame516WN (73:1086)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0.06 * fem, 15.02 * fem),
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // pickupK8E (73:1087)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    0 * fem,
                                                    6.96 * fem),
                                                child: Text(
                                                  'Pickup ',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12 * ffem,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.2000000477 *
                                                        ffem /
                                                        fem,
                                                    color: Color(0xff999999),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // frame61eRQ (73:1088)
                                                margin: EdgeInsets.fromLTRB(
                                                    0.02 * fem,
                                                    0 * fem,
                                                    0 * fem,
                                                    0 * fem),
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      // frame63zkA (73:1089)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              1 * fem),
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              1.75 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                      width: double.infinity,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            // calendarmonth746 (73:1090)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0.1 * fem,
                                                                    5.74 * fem,
                                                                    0 * fem),
                                                            width: 10.51 * fem,
                                                            height: 11.68 * fem,
                                                            child: Image.asset(
                                                              'assets/v3/images/calendarmonth-oKG.png',
                                                              width:
                                                                  10.51 * fem,
                                                              height:
                                                                  11.68 * fem,
                                                            ),
                                                          ),
                                                          Text(
                                                            // notonserviceCbL (73:1091)
                                                            'Not on service',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize:
                                                                  12 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height:
                                                                  1.2000000477 *
                                                                      ffem /
                                                                      fem,
                                                              color: Color(
                                                                  0xff232323),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      // frame646wc (73:1092)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0.01 * fem,
                                                              0 * fem,
                                                              1.99 * fem,
                                                              0 * fem),
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              2.33 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                      width: double.infinity,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            // locationonDWS (73:1093)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0.09 * fem,
                                                                    4.32 * fem,
                                                                    0 * fem),
                                                            width: 9.34 * fem,
                                                            height: 11.49 * fem,
                                                            child: Image.asset(
                                                              'assets/v3/images/locationon-qTg.png',
                                                              width: 9.34 * fem,
                                                              height:
                                                                  11.49 * fem,
                                                            ),
                                                          ),
                                                          Text(
                                                            // notonservicewSS (73:1094)
                                                            'Not on service',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize:
                                                                  12 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height:
                                                                  1.2000000477 *
                                                                      ffem /
                                                                      fem,
                                                              color: Color(
                                                                  0xff232323),
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
                                        Container(
                                          // frame52VD4 (73:1095)
                                          margin: EdgeInsets.fromLTRB(
                                              0.06 * fem,
                                              0 * fem,
                                              0 * fem,
                                              0 * fem),
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // destinationqXp (73:1096)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    0 * fem,
                                                    6.98 * fem),
                                                child: Text(
                                                  'Destination',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12 * ffem,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.2000000477 *
                                                        ffem /
                                                        fem,
                                                    color: Color(0xff999999),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // frame61TJJ (73:1097)
                                                margin: EdgeInsets.fromLTRB(
                                                    0.02 * fem,
                                                    0 * fem,
                                                    0 * fem,
                                                    0 * fem),
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      // frame63zp2 (73:1098)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              1 * fem),
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              1.75 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                      width: double.infinity,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            // calendarmonthXJA (73:1099)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0.1 * fem,
                                                                    5.74 * fem,
                                                                    0 * fem),
                                                            width: 10.51 * fem,
                                                            height: 11.68 * fem,
                                                            child: Image.asset(
                                                              'assets/v3/images/calendarmonth-Vzr.png',
                                                              width:
                                                                  10.51 * fem,
                                                              height:
                                                                  11.68 * fem,
                                                            ),
                                                          ),
                                                          Text(
                                                            // notonserviceCfC (73:1100)
                                                            'Not on service',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize:
                                                                  12 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height:
                                                                  1.2000000477 *
                                                                      ffem /
                                                                      fem,
                                                              color: Color(
                                                                  0xff232323),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      // frame647nA (73:1101)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0.01 * fem,
                                                              0 * fem,
                                                              1.99 * fem,
                                                              0 * fem),
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              2.33 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                      width: double.infinity,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            // locationonqCN (73:1102)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0.09 * fem,
                                                                    4.32 * fem,
                                                                    0 * fem),
                                                            width: 9.34 * fem,
                                                            height: 11.49 * fem,
                                                            child: Image.asset(
                                                              'assets/v3/images/locationon-s2a.png',
                                                              width: 9.34 * fem,
                                                              height:
                                                                  11.49 * fem,
                                                            ),
                                                          ),
                                                          Text(
                                                            // notonserviceW3c (73:1103)
                                                            'Not on service',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize:
                                                                  12 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height:
                                                                  1.2000000477 *
                                                                      ffem /
                                                                      fem,
                                                              color: Color(
                                                                  0xff232323),
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // autogroupi9zcefc (W2kJxXqjqGrhEuS5bCi9Zc)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0.27 * fem, 0 * fem, 0 * fem),
                              width: 51.02 * fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    // frame54nmp (73:1104)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 62.94 * fem),
                                    width: double.infinity,
                                    height: 18.05 * fem,
                                    decoration: BoxDecoration(
                                      color: Color(0xffecbc10),
                                      borderRadius:
                                          BorderRadius.circular(14 * fem),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Available',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 8 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.2000000477 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // arrowforwardios3Bx (73:1133)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 5.96 * fem, 0 * fem),
                                    width: 11.77 * fem,
                                    height: 20 * fem,
                                    child: Image.asset(
                                      'assets/v3/images/arrowforwardios-qnS.png',
                                      width: 11.77 * fem,
                                      height: 20 * fem,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // frame58xpi (73:1106)
                    left: 0.1772460938 * fem,
                    top: 199 * fem,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            16.01 * fem, 11.75 * fem, 16.16 * fem, 12.1 * fem),
                        width: 360.18 * fem,
                        height: 205.32 * fem,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffefebeb)),
                          color: Color(0xffffffff),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // frame56p6E (73:1107)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 78.92 * fem, 0 * fem),
                              width: 197.08 * fem,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // frame559uC (73:1108)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 15.01 * fem),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // chevroletnpr72975L (73:1109)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 7.03 * fem),
                                          child: Text(
                                            'Chevrolet Npr 729',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14 * ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.2175 * ffem / fem,
                                              color: Color(0xff232323),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // jahelprezcGz (73:1110)
                                          margin: EdgeInsets.fromLTRB(
                                              0.02 * fem,
                                              0 * fem,
                                              0 * fem,
                                              0 * fem),
                                          child: Text(
                                            'Jahel Pérez',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2000000477 * ffem / fem,
                                              color: Color(0xff232323),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // frame53JvW (73:1111)
                                    margin: EdgeInsets.fromLTRB(
                                        0.05 * fem, 0 * fem, 0 * fem, 0 * fem),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // frame51Fqk (73:1112)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 15.56 * fem),
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // pickupCkz (73:1113)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    0 * fem,
                                                    6.97 * fem),
                                                child: Text(
                                                  'Pickup ',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12 * ffem,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.2000000477 *
                                                        ffem /
                                                        fem,
                                                    color: Color(0xff999999),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // frame61KKp (73:1114)
                                                margin: EdgeInsets.fromLTRB(
                                                    0.02 * fem,
                                                    0 * fem,
                                                    0 * fem,
                                                    0 * fem),
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      // frame63SfL (73:1115)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              116.01 * fem,
                                                              1.45 * fem),
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              1.75 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                      width: double.infinity,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            // calendarmonthYiN (73:1116)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0.08 * fem,
                                                                    5.74 * fem,
                                                                    0 * fem),
                                                            width: 10.51 * fem,
                                                            height: 11.68 * fem,
                                                            child: Image.asset(
                                                              'assets/v3/images/calendarmonth-yp6.png',
                                                              width:
                                                                  10.51 * fem,
                                                              height:
                                                                  11.68 * fem,
                                                            ),
                                                          ),
                                                          Text(
                                                            // sVk (73:1117)
                                                            '15/09/2023',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize:
                                                                  12 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height:
                                                                  1.2000000477 *
                                                                      ffem /
                                                                      fem,
                                                              color: Color(
                                                                  0xff232323),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      // frame642Ne (73:1118)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0.02 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              2.33 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                      width: double.infinity,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            // locationonwVc (73:1119)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0.18 * fem,
                                                                    4.32 * fem,
                                                                    0 * fem),
                                                            width: 9.34 * fem,
                                                            height: 11.49 * fem,
                                                            child: Image.asset(
                                                              'assets/v3/images/locationon-GVY.png',
                                                              width: 9.34 * fem,
                                                              height:
                                                                  11.49 * fem,
                                                            ),
                                                          ),
                                                          Text(
                                                            // carrera102078bogotc5x (73:1120)
                                                            'Carrera 10 #20-78, Bogotá',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize:
                                                                  14 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height:
                                                                  1.2000000817 *
                                                                      ffem /
                                                                      fem,
                                                              color: Color(
                                                                  0xff232323),
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
                                        Container(
                                          // frame52jwG (73:1121)
                                          margin: EdgeInsets.fromLTRB(
                                              0.06 * fem,
                                              0 * fem,
                                              0 * fem,
                                              0 * fem),
                                          width: 184.03 * fem,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // destinationgrW (73:1122)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    0 * fem,
                                                    6.99 * fem),
                                                child: Text(
                                                  'Destination',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12 * ffem,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.2000000477 *
                                                        ffem /
                                                        fem,
                                                    color: Color(0xff999999),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // frame61zcJ (73:1123)
                                                margin: EdgeInsets.fromLTRB(
                                                    0.02 * fem,
                                                    0 * fem,
                                                    0 * fem,
                                                    0 * fem),
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      // frame63i2W (73:1124)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              100.01 * fem,
                                                              1.46 * fem),
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              1.75 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                      width: double.infinity,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            // calendarmonthSUJ (73:1125)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0.08 * fem,
                                                                    5.74 * fem,
                                                                    0 * fem),
                                                            width: 10.51 * fem,
                                                            height: 11.68 * fem,
                                                            child: Image.asset(
                                                              'assets/v3/images/calendarmonth-VCn.png',
                                                              width:
                                                                  10.51 * fem,
                                                              height:
                                                                  11.68 * fem,
                                                            ),
                                                          ),
                                                          Text(
                                                            // mWa (73:1126)
                                                            '20/09/2023',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize:
                                                                  12 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height:
                                                                  1.2000000477 *
                                                                      ffem /
                                                                      fem,
                                                              color: Color(
                                                                  0xff232323),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      // frame64KY6 (73:1127)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0.02 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              2.33 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                      width: double.infinity,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            // locationonpUr (73:1128)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0.17 * fem,
                                                                    4.32 * fem,
                                                                    0 * fem),
                                                            width: 9.34 * fem,
                                                            height: 11.49 * fem,
                                                            child: Image.asset(
                                                              'assets/v3/images/locationon-RQN.png',
                                                              width: 9.34 * fem,
                                                              height:
                                                                  11.49 * fem,
                                                            ),
                                                          ),
                                                          Text(
                                                            // carrera205323tunja6hG (73:1129)
                                                            'Carrera 20 #53-23, Tunja',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize:
                                                                  14 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height:
                                                                  1.2000000817 *
                                                                      ffem /
                                                                      fem,
                                                              color: Color(
                                                                  0xff232323),
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // autogroupxzog1pE (W2kLE5ZXQU6U9T7fkexZog)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0.27 * fem, 0 * fem, 0 * fem),
                              width: 52.02 * fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    // frame54vwC (73:1130)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 66.94 * fem),
                                    width: double.infinity,
                                    height: 18.05 * fem,
                                    decoration: BoxDecoration(
                                      color: Color(0xff8fd270),
                                      borderRadius:
                                          BorderRadius.circular(14 * fem),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'In Transit',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 8 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.2000000477 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // arrowforwardiosD9c (73:1132)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0.02 * fem, 0 * fem),
                                    child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Container(
                                        width: 24 * fem,
                                        height: 24 * fem,
                                        child: Image.asset(
                                          'assets/v3/images/arrowforwardios-d4W.png',
                                          width: 24 * fem,
                                          height: 24 * fem,
                                        ),
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
                  ),
                ],
              ),
            ),
            Container(
              // frame42JB4 (73:1076)
              margin:
                  EdgeInsets.fromLTRB(0.18 * fem, 0 * fem, 0.18 * fem, 0 * fem),
              padding:
                  EdgeInsets.fromLTRB(40 * fem, 8 * fem, 40 * fem, 16 * fem),
              width: double.infinity,
              height: 62 * fem,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x19000000),
                    offset: Offset(0 * fem, -2 * fem),
                    blurRadius: 4 * fem,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    // frame39auG (I73:1076;73:1425)
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 3.67 * fem, 0 * fem, 0 * fem),
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // home8A6 (I73:1076;73:1426)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 7.67 * fem),
                            width: 18.4 * fem,
                            height: 16.65 * fem,
                            child: Image.asset(
                              'assets/v3/images/home-b6r.png',
                              width: 18.4 * fem,
                              height: 16.65 * fem,
                            ),
                          ),
                          Center(
                            // homeeu8 (I73:1076;73:1427)
                            child: Text(
                              'Home',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 8 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.2000000477 * ffem / fem,
                                color: Color(0xff999999),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 102 * fem,
                  ),
                  Container(
                    // frame41mD4 (I73:1076;73:1428)
                    padding: EdgeInsets.fromLTRB(
                        0 * fem, 2.5 * fem, 0 * fem, 0 * fem),
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // directionsbusfilledsWz (I73:1076;73:1441)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 6.5 * fem),
                          width: 16 * fem,
                          height: 19 * fem,
                          child: Image.asset(
                            'assets/v3/images/directionsbusfilled-33x.png',
                            width: 16 * fem,
                            height: 19 * fem,
                          ),
                        ),
                        Center(
                          // trucksMh4 (I73:1076;73:1431)
                          child: Text(
                            'Loads',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 8 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.2000000477 * ffem / fem,
                              color: Color(0xff2e85ff),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 102 * fem,
                  ),
                  Container(
                    // frame40gjL (I73:1076;73:1435)
                    padding:
                        EdgeInsets.fromLTRB(0 * fem, 4 * fem, 0 * fem, 0 * fem),
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // personEkr (I73:1076;73:1436)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 8 * fem),
                          width: 16 * fem,
                          height: 16 * fem,
                          child: Image.asset(
                            'assets/v3/images/person-ika.png',
                            width: 16 * fem,
                            height: 16 * fem,
                          ),
                        ),
                        Center(
                          // profile8rE (I73:1076;73:1437)
                          child: Text(
                            'Profile',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 8 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.2000000477 * ffem / fem,
                              color: Color(0xff999999),
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
    );
  }
}

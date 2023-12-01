import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoricTripsScreen extends StatefulWidget {
  
  const HistoricTripsScreen({super.key});

  @override
  State<HistoricTripsScreen> createState() => _HistoricTripsScreenState();
}

class _HistoricTripsScreenState extends State<HistoricTripsScreen> {



  @override
  Widget build(BuildContext context) {
     double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      child: Text(" Historic Trips Screen",style : GoogleFonts.montserrat(
                                      fontSize: 20 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                                          
    );
  }
}
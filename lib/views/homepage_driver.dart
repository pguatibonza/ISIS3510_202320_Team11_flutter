import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tucamion/views/current_trip.dart';
import 'package:tucamion/views/historic_trips.dart';
import 'package:tucamion/views/profile.dart';
import 'package:tucamion/views/trailer.dart';

class HomePageDriver extends StatefulWidget {
  const HomePageDriver({super.key, required this.name});
  final String name;

  @override
  State<HomePageDriver> createState() => _HomePageDriverState();
}

class _HomePageDriverState extends State<HomePageDriver> {
  int currentIndex = 2;

  final List<Widget> _pages = [
    const CurrentTrip(),
    const HistoricTripsScreen(),
    const TrailerScreen(),
    const Profile()

  ];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
        appBar: AppBar(
          title: Text("Driver menu",
              style: GoogleFonts.montserrat(
                  fontSize: 20 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.2000000477 * ffem / fem,
                  color: Theme.of(context).textTheme.bodyMedium?.color)),
          centerTitle: true,
          backgroundColor: Color(0xFF2E85FF),
        ),
        body: _pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(

            backgroundColor: Color(0xFF2E85FF),
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                print(index);
                currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.fire_truck_sharp, color: Color(0xFF2E85FF),), label: 'Current Trip'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.trip_origin, color: Color(0xFF2E85FF)), label: 'Trips',),
              BottomNavigationBarItem(
                  icon: Icon(Icons.car_rental_rounded, color: Color(0xFF2E85FF)), label: 'Trailer'),
                BottomNavigationBarItem(icon: Icon(Icons.settings, color: Color(0xFF2E85FF)),label:'Settings')

            ]));
  }
}

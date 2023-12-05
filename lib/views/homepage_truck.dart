import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucamion/views/add_truck.dart';
import 'package:tucamion/views/profile.dart';
import 'package:tucamion/views/trucks.dart';

class HomePageTruck extends StatefulWidget {
  const HomePageTruck({super.key, required this.name});
  final String name;

  @override
  _HomePageTruckState createState() => _HomePageTruckState();
}

class _HomePageTruckState extends State<HomePageTruck> {
  int pageIndex = 0;

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      HomePageTruckContent(
          name: widget.name,
          updatePageIndex: () {
            setState(() {
              pageIndex = 1;
            });
          },
          createTruck: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddTruck(
                        name: widget.name,
                      )),
            );
          }),
      Trucks(
        ownerEmail: widget.name,
      ),
      Profile()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      padding: EdgeInsets.fromLTRB(40 * fem, 8 * fem, 40 * fem, 16 * fem),
      width: double.infinity,
      height: 62 * fem,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x19000000),
            offset: Offset(0 * fem, 0 * fem),
            blurRadius: 4 * fem,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.blue,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_filled,
                    color: Colors.grey,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.directions_bus_filled,
                    color: Colors.blue,
                    size: 35,
                  )
                : const Icon(
                    Icons.directions_bus_filled,
                    color: Colors.grey,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 35,
                  )
                : const Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}

class HomePageTruckContent extends StatelessWidget {
  const HomePageTruckContent(
      {super.key,
      required this.name,
      required this.updatePageIndex,
      required this.createTruck});

  final String name;
  final VoidCallback updatePageIndex;
  final Function() createTruck;

  Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the JSON string
    String? userJsonString = prefs.getString('user');
    dynamic userJson = jsonDecode(userJsonString!);
    return userJson["name"];
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Material(
      child: SizedBox(
        width: double.infinity,
        child: Container(
          // homepagefQv (73:917)
          padding: EdgeInsets.fromLTRB(0 * fem, 20 * fem, 0 * fem, 0 * fem),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // frame48LX4 (73:918)
                margin:
                    EdgeInsets.fromLTRB(16 * fem, 0 * fem, 16 * fem, 285 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // frame88t2n (73:919)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 24 * fem),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              // welcomepepitoQmp (73:920)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 8 * fem),
                              child: FutureBuilder<String?>(
                                future: getUser(), // Call getUser() here
                                builder: (BuildContext context,
                                    AsyncSnapshot<String?> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // Show a placeholder or loading indicator while waiting
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // Handle any errors here
                                    return Text('Welcome!');
                                  } else if (snapshot.hasData) {
                                    // Display the retrieved name
                                    String name = snapshot.data ??
                                        'User'; // Default name if null
                                    return Text(
                                      'Welcome $name!',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 24 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.2000000477 * ffem / fem,
                                      ),
                                    );
                                  } else {
                                    // Handle the case when there's no data
                                    return Text('Welcome!');
                                  }
                                },
                              )),
                          Text(
                            // servicesW4A (73:921)
                            'Services',
                            style: GoogleFonts.montserrat(
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.2000000212 * ffem / fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // frame47rNv (73:922)
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // frame48Pdk (73:923)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 10 * fem),
                            child: TextButton(
                              onPressed: createTruck,
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
                                      color: Color(0x19000000),
                                      offset: Offset(0 * fem, 1 * fem),
                                      blurRadius: 4 * fem,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // package1dHC (73:924)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 16 * fem, 0 * fem),
                                      width: 48 * fem,
                                      height: 48 * fem,
                                      child: Image.asset(
                                        'assets/images/package.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      // frame46ukW (73:925)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 6 * fem, 0 * fem, 6 * fem),
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // addatruckFZU (73:926)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 3 * fem),
                                            child: Text(
                                              'Add a truck',
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
                                            // earnbyregisteringatruckN8J (73:927)
                                            'Earn by registering a truck',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height:
                                                    1.2000000477 * ffem / fem,
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
                          ),
                          TextButton(
                            // frame47JXk (73:928)
                            onPressed: updatePageIndex,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                  16 * fem, 16 * fem, 77 * fem, 16 * fem),
                              width: double.infinity,
                              height: 80 * fem,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6 * fem),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    offset: Offset(0 * fem, 1 * fem),
                                    blurRadius: 4 * fem,
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // tracking1oDc (73:929)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 16 * fem, 0 * fem),
                                    width: 48 * fem,
                                    height: 48 * fem,
                                    child: Image.asset(
                                      'assets/images/tracking.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    // frame46w4v (73:930)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 6 * fem, 0 * fem, 6 * fem),
                                    height: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // manageyourtrucksREz (73:931)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 3 * fem),
                                          child: Text(
                                            'Manage your trucks',
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
                                          // seethestatusofyourtrucksvSe (73:932)
                                          'See the status of your trucks',
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
            ],
          ),
        ),
      ),
    );
  }
}

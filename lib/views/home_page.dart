import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:tucamion/controller/citycontroller.dart';
import 'package:tucamion/controller/connectivityController.dart';
import 'package:tucamion/views/CustomAlertDialog.dart';
import 'package:tucamion/views/add_accesspoint.dart';
import 'package:tucamion/controller/api.dart';
import 'package:tucamion/models/access_point.dart';
import 'package:tucamion/models/load.dart';
import 'package:tucamion/models/trip.dart';
import 'package:tucamion/controller/locationcontroller.dart';
import 'package:tucamion/views/trip_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.name});

  final String name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Trip> myTrips = [];
  List<AccessPoint> myAccessPoints = [];
  List<Load> myLoads = [];
  final cacheManager = DefaultCacheManager();


  @override
  void initState() {
    super.initState();
    fetchData();
  }

  
 Future<void> fetchData() async {
  
  
  try {
    FileInfo? fileInfo = await cacheManager.getFileFromCache('Trips');

    if (fileInfo != null && fileInfo.file.existsSync() ) {
      // Data is found in the cache
      final cachedData = await fileInfo.file.readAsString();
      final data = json.decode(cachedData);
      print(data);
      await updateListsFromData(data);
      print("Data found in the cache");

    } else {
      print("No data found in the cache");
      final response = await http.get(Uri.parse(trips));
      final data = json.decode(response.body);
      
      // Update lists from the fetched data
      await updateListsFromData(data);  // Make the call to the async function

      // Save the fetched data to the cache
      cacheManager.putFile('Trips', Uint8List.fromList(json.encode(data).codeUnits));
    }

    setState(() {
      // Update the state with the fetched data
      myTrips = myTrips;
      myAccessPoints = myAccessPoints;
      myLoads = myLoads;
    });
  } catch (e) {
    print("error$e");
  }
}

Future<void> updateListsFromData(List<dynamic> data) async {
  for (var trip in data) {
    final t = Trip.fromJson(trip);
    myTrips.add(t);
    
    final pickupResponse = await http.get(Uri.parse('$accessPoints/${t.pickup}'));
    final dataAccess = json.decode(pickupResponse.body);
    
    final a = AccessPoint.fromJson(dataAccess);
    myAccessPoints.add(a);
    
    final dropoffResponse = await http.get(Uri.parse('$accessPoints/${t.dropoff}'));
    final dataDropoff = json.decode(dropoffResponse.body);
    
    final aDropoff = AccessPoint.fromJson(dataDropoff);
    myAccessPoints.add(aDropoff);
    
    final loadResponse = await http.get(Uri.parse('$loads/${t.load}'));
    final dataLoad = json.decode(loadResponse.body);
    
    final l = Load.fromJson(dataLoad);
    myLoads.add(l);
  }
}


  @override
  Widget build(BuildContext context) {
    return ListTrips(
      myTrips: myTrips,
      myAccessPoints: myAccessPoints,
      myLoads: myLoads,
      name: widget.name,
    );
  }
}


class ListTrips extends StatelessWidget {
  const ListTrips({
    super.key,
    required this.myTrips,
    required this.myAccessPoints,
    required this.myLoads,
    required this.name,
  });

  final List<Trip> myTrips;
  final List<AccessPoint> myAccessPoints;
  final List<Load> myLoads;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const LoadButton(),
        bottomNavigationBar: NavigationBar(),
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.fromLTRB(5, 50, 5, 0),
          child: Column(
            children: [
              FutureBuilder<String>(
                future: salute(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // If the Future is still running, show a loading indicator.
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // If we run into an error, display it to the user.
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // If the Future is complete and no errors occurred, display the created posts.
                    return Text(
                      snapshot.data!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 1.2000000477,
                      ),
                    );
                  }
                },
              ),
              Expanded(
                child: ListBuilder(
                    myTrips: myTrips,
                    myAccessPoints: myAccessPoints,
                    myLoads: myLoads),
              ),
            ],
          ),
        ));
  }

  Future<String> salute() async {
    var locationService = LocationService();
    LocationData locationData = await getLocation();

    double latitude = locationData.latitude ?? 0.0;
    double longitude = locationData.longitude ?? 0.0;

    String cityName =
        await locationService.getCityFromCoordinates(latitude, longitude);
    return "Welcome back!\n" +
        name ;
  }

  Future<LocationData> getLocation() async {
    var locationController = LocationController();
    await locationController.getUserLocation();
    LocationData? location = locationController.currentLocation;

    return location!;
  }
}

class ListBuilder extends StatelessWidget {
  const ListBuilder({
    super.key,
    required this.myTrips,
    required this.myAccessPoints,
    required this.myLoads,
  });

  final List<Trip> myTrips;
  final List<AccessPoint> myAccessPoints;
  final List<Load> myLoads;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return ListView.builder(
      itemCount: myTrips.length,
      itemBuilder: (context, index) {
        var pickup = myAccessPoints
            .where((element) => element.id == myTrips[index].pickup)
            .first;
        var dropoff = myAccessPoints
            .where((element) => element.id == myTrips[index].dropoff)
            .first;
        var load =
            myLoads.where((element) => element.id == myTrips[index].load).first;
        //var pickupDate=DateTime(pickup.after.year,pickup.after.month,pickup.after.day);
        //var dropoffDate=DateTime(dropoff.after.year,dropoff.after.month,dropoff.after.day);
        return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Card(
              
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: GestureDetector(
                onTapUp: (details){
                  if(ConnectivityController.hasInternet){
                     Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TripDetails(
                        trip: myTrips[index],
                        pickup: pickup,
                        dropoff: dropoff,
                        load: load,
                      ),
                    ),
                  );

                  }
                  else{
                    CustomAlertDialog.showAlertDialog(context);
                  }
                 
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(load.type, style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color),),
                            Text('${load.weight} kgs ',style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                            SizedBox(height: 10),
                            Text('Pickup',style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                            Text(pickup.after.toString(),style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                            Row(
                              children: [
                                Text(pickup.address,style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                                Text(pickup.city, style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text('Dropoff',style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                            Text(dropoff.before.toString()),
                            Row(
                              children: [
                                Text(dropoff.address,style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                                Text(dropoff.city,style: GoogleFonts.montserrat(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2000000477 * ffem / fem,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color)),
                              ],
                            ),
                          ],
                        ),
                        Text(myTrips[index].status)
                      ],
                    )),
              ),
            ));
      },
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.fire_truck), label: 'Trips'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
      ],
    );
  }
}

class LoadButton extends StatelessWidget {
  const LoadButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      highlightElevation: 0,
      child: Icon(Icons.add),
      onPressed: () {
        bool hasInternet=ConnectivityController.hasInternet;
        if(hasInternet) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    AddAccessPoint(pointType: 1,pointId: 0)));
        } 
        else{
          CustomAlertDialog.showAlertDialog(context);
        }
      },
    );
  }
}

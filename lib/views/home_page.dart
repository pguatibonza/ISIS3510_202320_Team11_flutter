import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:tucamion/controller/citycontroller.dart';
import 'package:tucamion/views/add_accesspoint.dart';
import 'package:tucamion/controller/api.dart';
import 'package:tucamion/models/access_point.dart';
import 'package:tucamion/models/load.dart';
import 'package:tucamion/models/trip.dart';
import 'package:tucamion/controller/locationcontroller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.name});

  final String name;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Trip> myTrips = [];
  List<AccessPoint> myAcessPoints = [];
  List<Load> myLoads = [];

  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse(trips));
      var data = json.decode(response.body);
      print(data);
      data.forEach((trip) async {
        Trip t = Trip(
            id: trip["id"],
            loadOwner: trip["loadOwner"],
            trailer: trip["trailer"],
            load: trip["load"],
            pickup: trip["pickup"],
            dropoff: trip["dropoff"],
            status: trip["status"]);
        myTrips.add(t);

        try {
          http.Response response =
              await http.get(Uri.parse('$accessPoints/${t.pickup}'));

          var dataAccess = json.decode(response.body);
          print(dataAccess);
          AccessPoint a = AccessPoint(
              id: dataAccess["id"],
              country: dataAccess["country"],
              city: dataAccess["city"],
              address: dataAccess["address"],
              before: DateTime.parse(dataAccess["before"]),
              after: DateTime.parse(dataAccess["after"]));
          myAcessPoints.add(a);
          response = await http.get(Uri.parse('$accessPoints/${t.dropoff}'));
          dataAccess = json.decode(response.body);
          print(response.body);
          a = AccessPoint(
              id: dataAccess["id"],
              country: dataAccess["country"],
              city: dataAccess["city"],
              address: dataAccess["address"],
              before: DateTime.parse(dataAccess["before"]),
              after: DateTime.parse(dataAccess["after"]));
          myAcessPoints.add(a);
          response = await http.get(Uri.parse('$loads/${t.load}'));
          var dataLoad = json.decode(response.body);
          Load l = Load(
              id: dataLoad["id"],
              type: dataLoad["type"],
              trailerType: dataLoad["trailerType"],
              weight: dataLoad["weight"],
              volume: dataLoad["volume"]);
          myLoads.add(l);
        } catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTrips(
        myTrips: myTrips,
        myAcessPoints: myAcessPoints,
        myLoads: myLoads,
        name: widget.name);
  }
}

class ListTrips extends StatelessWidget {
  const ListTrips({
    super.key,
    required this.myTrips,
    required this.myAcessPoints,
    required this.myLoads,
    required this.name,
  });

  final List<Trip> myTrips;
  final List<AccessPoint> myAcessPoints;
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
                        color: const Color(0xff232323),
                      ),
                    );
                  }
                },
              ),
              Expanded(
                child: ListBuilder(
                    myTrips: myTrips,
                    myAcessPoints: myAcessPoints,
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
        name +
        "\n\n" +
        "Look for trucks at your city " +
        cityName;
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
    required this.myAcessPoints,
    required this.myLoads,
  });

  final List<Trip> myTrips;
  final List<AccessPoint> myAcessPoints;
  final List<Load> myLoads;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myTrips.length,
      itemBuilder: (context, index) {
        var pickup = myAcessPoints
            .where((element) => element.id == myTrips[index].pickup)
            .first;
        var dropoff = myAcessPoints
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
                          Text(load.type),
                          Text('${load.weight} kgs '),
                          SizedBox(height: 10),
                          Text('Pickup'),
                          Text(pickup.after.toString()),
                          Row(
                            children: [
                              Text(pickup.address),
                              Text(pickup.city),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text('Dropoff'),
                          Text(dropoff.before.toString()),
                          Row(
                            children: [
                              Text(dropoff.address),
                              Text(dropoff.city),
                            ],
                          ),
                        ],
                      ),
                      Text(myTrips[index].status)
                    ],
                  )),
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    AddAccessPoint(pointType: 1)));
      },
    );
  }
}

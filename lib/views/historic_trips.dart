import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucamion/controller/api.dart';
import 'package:http/http.dart' as http;
import 'package:tucamion/controller/connectivityController.dart';
import 'package:tucamion/models/access_point.dart';
import 'package:tucamion/models/load.dart';
import 'package:tucamion/models/trip.dart';
import '../models/trailer.dart';
import 'dart:convert';

class HistoricTripsScreen extends StatefulWidget {
  
  const HistoricTripsScreen({super.key});

  @override
  State<HistoricTripsScreen> createState() => _HistoricTripsScreenState();
}

class _HistoricTripsScreenState extends State<HistoricTripsScreen> {
  Trailer? trailer;
   List<Trip> myTrips = [];
  List<AccessPoint> myAccessPoints = [];
  List<Load> myLoads = [];
  final cacheManager = DefaultCacheManager();
   void initState() {
    super.initState();
    fetchData();

  }



   Future<void> fetchData() async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = int.parse(prefs.getString('id')!);
    
    print("user $userId");
    final response = await http.get(Uri.parse('$trailers/driver/$userId'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      if (data.length > 0) {
        setState(() {
          trailer = Trailer.fromJson(data[0]);
        });
      }
    } else {
      throw Exception('Failed to load Trailer');
    }


  try {
    
    FileInfo? fileInfo = await cacheManager.getFileFromCache('TripsDriver');

    if (fileInfo != null && !ConnectivityController.hasInternet) {
      // Data is found in the cache
      final cachedData = await fileInfo.file.readAsString();
      final data = json.decode(cachedData);
      print(data);
      await updateListsFromData(data);
      print("Data found in the cache");

    } else {
      print("Retrieving data ");
      final response = await http.get(Uri.parse('$TRIPSDRIVER/${trailer!.id}'));
      final data = json.decode(response.body);
      print(data);
      // Update lists from the fetched data
      await updateListsFromData(data);  // Make the call to the async function

      // Save the fetched data to the cache
      cacheManager.putFile('TripsDriver', Uint8List.fromList(json.encode(data).codeUnits));
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
     double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return ListBuilder(myTrips: myTrips, myAccessPoints: myAccessPoints, myLoads: myLoads);
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
                  // if(ConnectivityController.hasInternet){
                  //    Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => TripDetails(
                  //       trip: myTrips[index],
                  //       pickup: pickup,
                  //       dropoff: dropoff,
                  //       load: load,
                  //     ),
                  //   ),
                  // );

                  // }
                  // else{
                  //   CustomAlertDialog.showAlertDialog(context);
                  // }
                 
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



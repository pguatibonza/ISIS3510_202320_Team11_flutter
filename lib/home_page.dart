import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tucamion/add_accesspoint.dart';
import 'package:tucamion/constants/api.dart';
import 'package:tucamion/models/access_point.dart';
import 'package:tucamion/models/load.dart';
import 'package:tucamion/models/trip.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Trip> myTrips=[];
  List<AccessPoint> myAcessPoints=[];
  List<Load> myLoads=[];

  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse(trips));
      var data=json.decode(response.body);
      print(data);
      data.forEach((trip) async {
        Trip t= Trip(
          id: trip["id"],
          loadOwner: trip["loadOwner"],
          trailer: trip["trailer"],
          load: trip["load"],
          pickup: trip["pickup"],
          dropoff: trip["dropoff"],
          status: trip["status"]
        );
        myTrips.add(t);
        
        try{
          http.Response response = await http.get(Uri.parse('$accessPoints/${t.pickup}'));
          
          var dataAccess=json.decode(response.body);
          print(dataAccess);
            AccessPoint a= AccessPoint(
              id: dataAccess["id"],
              country: dataAccess["country"],
              city: dataAccess["city"],
              address: dataAccess["address"],
              before: DateTime.parse(dataAccess["before"]),
              after: DateTime.parse(dataAccess["after"])
            );
            myAcessPoints.add(a);
          response = await http.get(Uri.parse('$accessPoints/${t.dropoff}'));
          dataAccess = json.decode(response.body);
          print(response.body);
          a= AccessPoint(

            id: dataAccess["id"],
            country: dataAccess["country"],
            city: dataAccess["city"],
            address: dataAccess["address"],
            before: DateTime.parse(dataAccess["before"]),
            after: DateTime.parse(dataAccess["after"])
          );
          myAcessPoints.add(a);
          response = await http.get(Uri.parse('$loads/${t.load}'));
          var dataLoad=json.decode(response.body);
          Load l= Load(
            id: dataLoad["id"],
            type: dataLoad["type"],
            trailerType: dataLoad["trailerType"],
            weight: dataLoad["weight"],
            volume: dataLoad["volume"]
          );
          myLoads.add(l);
          }
          catch(e){
          print(e);
        }
        }
        

        );
    
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
    return ListTrips(myTrips: myTrips, myAcessPoints: myAcessPoints, myLoads: myLoads);
      
  }
}

class ListTrips extends StatelessWidget {
  const ListTrips({
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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: LoadButton() ,
      bottomNavigationBar: NavigationBar(),
      appBar: AppBar(),
      body: ListBuilder(myTrips: myTrips, myAcessPoints: myAcessPoints, myLoads: myLoads)
      );
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
      itemBuilder: (context,index){
        var pickup=myAcessPoints.where((element) => element.id==myTrips[index].pickup).first;
        var dropoff=myAcessPoints.where((element) => element.id==myTrips[index].dropoff).first;
        var load=myLoads.where((element) => element.id==myTrips[index].load).first;
        //var pickupDate=DateTime(pickup.after.year,pickup.after.month,pickup.after.day);
        //var dropoffDate=DateTime(dropoff.after.year,dropoff.after.month,dropoff.after.day);
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical:5),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0)
              ),
            child:Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical:10),
              child:Row(
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
              )
            ) ,
            )
          );  
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
        BottomNavigationBarItem( icon : Icon(Icons.fire_truck), label : 'Trips'),
        BottomNavigationBarItem( icon : Icon(Icons.settings),label :'Settings')
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
      child : Icon(Icons.add),
      onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddAccessPoint(pointType: 1) ));
    },
    );
  }
}

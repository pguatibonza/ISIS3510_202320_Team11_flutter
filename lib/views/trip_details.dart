import 'package:flutter/material.dart';
import 'package:tucamion/models/access_point.dart';
import 'package:tucamion/models/load.dart';
import 'package:tucamion/models/trip.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({super.key,required this.trip,required this.pickup,required this.dropoff,required this.load});
  final Trip trip;
  final AccessPoint pickup;
  final AccessPoint dropoff;
  final Load load;

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
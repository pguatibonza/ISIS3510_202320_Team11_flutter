import 'package:flutter/material.dart';
import 'package:tucamion/add_pickup.dart';

class AddDropoff extends StatelessWidget {
  const AddDropoff({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Dropoff'),
      ),
      body: AccessPointForm(),
    );
  }
}
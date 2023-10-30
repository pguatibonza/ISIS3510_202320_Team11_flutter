import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tucamion/views/add_load.dart';
import 'package:tucamion/controller/api.dart';
import 'package:tucamion/models/access_point.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AddAccessPoint extends StatelessWidget {
  final int pointType;
  final int pointId;

  const AddAccessPoint({required this.pointType, required this.pointId, super.key,});

  @override
  Widget build(BuildContext context) {
    String _text = "";
    if (pointType == 1) {
      _text = "Add pickup";
    } else {
      _text = "Add dropoff";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_text),
      ),
      body: AccessPointForm(pointType: pointType, pointId: pointId,),
    );
  }
}

class AccessPointForm extends StatefulWidget {
  final int pointType;
  final int pointId;
  const AccessPointForm({required this.pointType, required this.pointId, super.key});
  
  

  @override
  State<AccessPointForm> createState() => _AccessPointFormState();
}

class _AccessPointFormState extends State<AccessPointForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  DateTime _dateTime1 = DateTime.now();
  DateTime _dateTime2 = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _countryController,
              decoration: InputDecoration(labelText: 'Country'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the country';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _cityController,
              decoration: InputDecoration(labelText: 'City'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the city';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the address';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _selectDateAndTime(1),
              child: Text('After '),
            ),
            SizedBox(height: 16),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _selectDateAndTime(2),
              child: Text('Before'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                     if (_formKey.currentState!.validate()) {
                    Future<int> accessPointId = post();
                    accessPointId.then((result){
                      int accessPointIdAwaited=result;
                      if (widget.pointType == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AddAccessPoint(pointType: 2, pointId: accessPointIdAwaited ,)));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => AddLoad(
                                  pickupId: widget.pointId,
                                  dropoffId: accessPointIdAwaited,)));
                    }
                    });
                     }
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    fillFormFieldsWithLocationData();
                  },
                  child: Text('Fill with Location Data'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<int> post() async {
    var id = 0;
    print("Posting data");
    if (_formKey.currentState!.validate()) {
      // Form is valid, process the data
      try {
        http.Response response = await http.post(Uri.parse(accessPoints),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              "country": _countryController.text,
              "city": _cityController.text,
              "address": _addressController.text,
              "after": _dateTime1.toString(),
              "before": _dateTime2.toString(),
            }));
        if (response.statusCode == 201) {
          setState(() {
            id = json.decode(response.body)["id"];
            print("AccessPoint created");
          });
        } else {
          print("AccessPoint not created");
        }
      } catch (e) {
        print(e);
      }
    }

    return id;
  }

//Retrieve current location
  Future<Position> getUserLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

//reverse geocode the user's location to obtain country, city, and address:
  Future<Map<String, String>> reverseGeocode(Position position) async {
    final placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      final country = placemark.country;
      final city = placemark.locality;
      final address = placemark.street;

      return {
        'country': country ?? 'Unknown',
        'city': city ?? 'Unknown',
        'address': address ?? 'Unknown',
      };
    }

    return {
      'country': 'Unknown',
      'city': 'Unknown',
      'address': 'Unknown',
    };
  }

//fill form fields with retrieved data
  void fillFormFieldsWithLocationData() async {
    print("p");
    try {
      final userLocation = await getUserLocation();
      final locationData = await reverseGeocode(userLocation);
      print("pp");

      setState(() {
        _countryController.text = locationData['country'] ?? '';
        _cityController.text = locationData['city'] ?? '';
        _addressController.text = locationData['address'] ?? '';
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _selectDateAndTime(int index) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        setState(() {
          if (index == 1) {
            _dateTime1 = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
          } else if (index == 2) {
            _dateTime2 = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
          }
        });
      }
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tucamion/constants/api.dart';
import 'package:tucamion/models/access_point.dart';

class AddPickup extends StatelessWidget {
  final pickupId=0;
  const AddPickup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Pickup'),
      ),
      body: AccessPointForm(),
    );
  }
}
class AccessPointForm extends StatefulWidget {
  const AccessPointForm({super.key});

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
            ElevatedButton(
              onPressed: post,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<int>  post()   async {
              var pickupId=0;
              print("Posting data");
              if (_formKey.currentState!.validate()) {
                // Form is valid, process the data
                  try{
                    http.Response response= await http.post(
                      Uri.parse(accessPoints),
                      headers:<String,String>{
                        'Content-Type':'application/json; charset=UTF-8',
                        
                      },
                      body: jsonEncode(<String,String>{
                        "country": _countryController.text,
                        "city": _cityController.text,
                        "address": _addressController.text,
                        "after": _dateTime1.toString() ,
                        "before": _dateTime2.toString(),
                      })
                    );
                    if (response.statusCode== 201 ){
                      setState(() {
                         pickupId = json.decode(response.body)["id"];
                      });

                    }
                    else {
                      print("AccessPoint not created");
                    }
                  }

                  catch(e){
                    print(e);
                }
                
              
            }
            return pickupId;
            
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

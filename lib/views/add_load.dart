import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tucamion/controller/api.dart';
import 'package:tucamion/controller/usercontroller.dart';
import 'package:tucamion/models/load.dart';
import 'package:tucamion/views/home_page.dart';

class AddLoad extends StatelessWidget {
  final int pickupId;
  final int dropoffId;
  const AddLoad({super.key, required this.pickupId, required this.dropoffId});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Add Load"),
      ),
      body: LoadForm(
        pickupId: pickupId,
        dropoffId: dropoffId,
      ),
    );
  }
}

class LoadForm extends StatefulWidget {
  final int pickupId;
  final int dropoffId;

  const LoadForm({required this.pickupId, required this.dropoffId, super.key});
  @override
  _LoadFormState createState() => _LoadFormState();
}

class _LoadFormState extends State<LoadForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _volumeController = TextEditingController();

  Choice _trailerType=choices[0]; // Dropdown value

// Replace with your list of trailer types.

  @override
  Widget build(BuildContext context) {
  
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _typeController,
            decoration: InputDecoration(labelText: 'Type'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the type';
              }
              return null;
            },
          ),
          DropdownButtonFormField<Choice>(
            value: _trailerType,
            items: choices.map((item) {
              return DropdownMenuItem<Choice>(
                value: item,
                child: Text(item.label),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _trailerType = value!;
              });
            },
            decoration: InputDecoration(labelText: 'Trailer Type'),
            validator: (value) {
              if (value == null || value.value.isEmpty) {
                return 'Please select a trailer type';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _weightController,
            decoration: InputDecoration(labelText: 'Weight'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the weight';
              }
              if (int.tryParse(value) == null) {
                return 'Weight must be a number';
              }
              if(int.parse(value) <= 0 ){
                return 'Weight must be positive';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _volumeController,
            decoration: InputDecoration(labelText: 'Volume (optional)'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                if (int.tryParse(value) == null) {
                  return 'Volume must be a number';
                }
                if(int.parse(value) <= 0 ){
                  return 'Volume must be positive';
                }
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
               if (_formKey.currentState!.validate()) {
              Future<int> loadId = postLoad();
              loadId.then((value){
                int awaitedLoadId=value;
                postTrip(awaitedLoadId, widget.pickupId, widget.dropoffId);
              });
               }            
            },
            child: Text('Create Trip'),
          ),
        ],
      ),
    );
  }

  Future<int> postLoad() async {
    var id = 0;
    print("Posting data...");
    if (_formKey.currentState!.validate()) {
      final type = _typeController.text;
      final weight = int.tryParse(_weightController.text) ?? 0;
      final volume = int.tryParse(_volumeController.text) ?? null;
      final trailerType = _trailerType;
      try {
        http.Response response = await http.post(Uri.parse(loads),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              "type": type,
              "trailerType": trailerType.value,
              "weight": weight,
              "volume": volume
            }));
        if (response.statusCode == 201) {
          setState(() {
            id = json.decode(response.body)["id"];
            print("Load created");
          });
        } else {
          print("Load not created");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Form is not valid");
    }
    return id;
  }
  void postTrip(int loadId,int pickupId,int dropoffId) async{
    int? userId = UserController.savedUser.id;
    String status ='TA';
    try {
      http.Response response= await http.post(Uri.parse(trips),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "load": loadId.toString(),
        "loadOwner": userId.toString(),
        "pickup": pickupId.toString(),
        "dropoff": dropoffId.toString(),
        "status": status
      }));
      if (response.statusCode == 201) {
        print("Trip created");
       // ignore: use_build_context_synchronously
       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePage(name: UserController.savedUser.name!)));
      } else {
        print("Trip not created");
      }
    }
    catch(e){
      print("Error $e");
    }
  }
}

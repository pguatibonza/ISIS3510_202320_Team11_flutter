import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tucamion/controller/api.dart';

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

  String _trailerType = 'Any'; // Dropdown value

  List<String> _trailerTypes = [
    'Any',
    'Flatbed',
    'Dryvan',
    'Reefer',
    'Stepdeck',
    'Other'
  ]; // Replace with your list of trailer types.

  @override
  Widget build(BuildContext context) {
    print(_trailerTypes);
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
          DropdownButtonFormField<String>(
            value: _trailerType,
            items: _trailerTypes.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _trailerType = value!;
              });
            },
            decoration: InputDecoration(labelText: 'Trailer Type'),
            validator: (value) {
              if (value == null || value.isEmpty) {
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
              return null;
            },
          ),
          TextFormField(
            controller: _volumeController,
            decoration: InputDecoration(labelText: 'Volume (optional)'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Here, you can submit the data to an API or perform other actions.
              Future<int> loadId = postLoad();
              loadId.then((value){
                int awaitedLoadId=value;
                postTrip(awaitedLoadId, widget.pickupId, widget.dropoffId);


              });
            },
            child: Text('Create Trip'),
          ),
        ],
      ),
    );
  }

  Future<int> postLoad() async {
    var id = 0;
    print("Posting data");
    if (_formKey.currentState!.validate()) {
      final type = _typeController.text;
      final weight = int.tryParse(_weightController.text) ?? 0;
      final volume = _volumeController.text.isNotEmpty
          ? int.tryParse(_volumeController.text)
          : null;

      final trailerType = _trailerType;
      try {
        http.Response response = await http.post(Uri.parse(loads),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              "type": type,
              "trailerType": trailerType,
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
  Future<int> postTrip(int loadId,int pickupId,int dropoffId) async{
    return 0;
  }
}

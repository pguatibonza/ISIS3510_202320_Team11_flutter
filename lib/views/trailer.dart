import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucamion/controller/api.dart';
import '../models/trailer.dart';
import 'dart:convert';

class TrailerScreen extends StatefulWidget {
  const TrailerScreen({super.key});

  @override
  State<TrailerScreen> createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  Trailer? trailer;

  Future<void> fetchDriver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = int.parse(prefs.getString('id')!);

    await getDriver(userId);
  }

  Future<void> getDriver(int userId) async {
    // ignore: avoid_print
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
  }

  @override
  void initState() {
    super.initState();
    fetchDriver();
  }

 @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Text(
                "Your trailer",
                style: GoogleFonts.montserrat(
                  fontSize: 35* ffem,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              SizedBox(width: 50),

              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 2 * fem),
                child: TextButton(
                  onPressed: () async {
                    if (trailer == null) {
                      print("trailer null");
                    } else {
                      await assignTrailer();
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    width: 48 * fem,
                    height: 48 * fem,
                    child: IconButton(
                      enableFeedback: false,
                      onPressed: () async {
                        if (trailer != null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Driver has a trailer'),
                                content: Text(
                                  'Driver is already assigned to a trailer. Cannot assign.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          print("trailer null");
                          await assignTrailer();
                        }
                      },
                      icon: Icon(
                        Icons.add_circle_rounded,
                        color: Colors.blue,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),




            ],
          ),
        
          Row(
            children: [
              
              if (trailer != null)
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 16 * fem),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trailer Info:',
                          style: GoogleFonts.montserrat(
                            fontSize: 30 * ffem,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'ID: ${trailer!.id}',
                          style: GoogleFonts.montserrat(
                            fontSize: 25 * ffem,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Plates: ${trailer!.plates}',
                          style: GoogleFonts.montserrat(
                            fontSize: 25 * ffem,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Capacity: ${trailer!.capacity}',
                          style: GoogleFonts.montserrat(
                            fontSize: 25 * ffem,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        // Agrega otra información del remolque según sea necesario
                      ],
                    ),
                  ),
                ),
              if (trailer == null)
                Container(
                  margin: EdgeInsets.only(left: 16 * fem,top: 25*fem),
                  child: Text(
                    'You have no current trailer',
                    style: GoogleFonts.montserrat(
                      fontSize: 20 * ffem,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16),
          Center(
            
            child: Container(
              margin: EdgeInsets.only(top: ffem * 40),
              child: ElevatedButton(
                onPressed: () {
                  fetchDriver(); // Llama a tu función asíncrona aquí
                },
                child: Text('Reload'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  assignTrailer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = int.parse(prefs.getString('id')!);

    const url='${api}assignTrailer'; 
    try{
      final response=await http.put(Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId}),
      );
      if (response.statusCode == 200) {
      print('Driver assigned successfully.');
      getDriver(userId);
      // Handle success, if needed
    } else {
      print('Failed to assign driver. Status code: ${response.statusCode}');
      // Handle failure, if needed
    }
  } catch (e) {
    print('Error: $e');
    }
  }



 
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucamion/controller/api.dart';
import 'package:tucamion/models/access_point.dart';
import 'package:tucamion/models/load.dart';
import 'package:tucamion/models/trailer.dart';
import 'package:tucamion/models/trip.dart';
import 'package:http/http.dart' as http;
import 'package:tucamion/controller/connectivityController.dart';
import 'package:tucamion/views/CustomAlertDialog.dart';

class CurrentTrip extends StatefulWidget {
  const CurrentTrip({super.key});

  @override
  State<CurrentTrip> createState() => _CurrentTripState();
}

class _CurrentTripState extends State<CurrentTrip> {
  LatLng _pickupLocation = LatLng(0.0, 0.0);
  LatLng _dropoffLocation = LatLng(0.0, 0.0);
  LatLng _bogota = LatLng(4.624335, -74.063644);
  Trailer? trailer;
  Trip? tripsito;
  AccessPoint? pickup;
  AccessPoint? dropoff;
  Load? load;

  @override
  void initState() {
    super.initState();
    fetchTripDetails();
  }

  Future<void> fetchTripDetails() async {
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

    print("Retrieving data ");
    try {
      final response2 =
          await http.get(Uri.parse('$TRIPSDRIVER/${trailer!.id}/status/IP'));
      if (response2.statusCode == 200) {
        var data2 = json.decode(response2.body)[0];

        print(data2);

        tripsito = Trip.fromJson(data2);

        final pickupResponse =
            await http.get(Uri.parse('$accessPoints/${tripsito?.pickup}'));
        final dataAccess = json.decode(pickupResponse.body);

        pickup = AccessPoint.fromJson(dataAccess);

        final dropoffResponse =
            await http.get(Uri.parse('$accessPoints/${tripsito?.dropoff}'));
        final dataDropoff = json.decode(dropoffResponse.body);

        dropoff = AccessPoint.fromJson(dataDropoff);

        final loadResponse =
            await http.get(Uri.parse('$loads/${tripsito?.load}'));
        final dataLoad = json.decode(loadResponse.body);

        load = Load.fromJson(dataLoad);

        String pickupAddress =
            "${pickup?.address}, ${pickup?.city}, ${pickup?.country}";
        String dropoffAddress =
            "${dropoff?.address}, ${dropoff?.city}, ${dropoff?.country}";

        await getCoordinatesFromAddress(pickupAddress).then((coordinates) {
          setState(() {
            _pickupLocation = coordinates;
          });
        });
        await getCoordinatesFromAddress(dropoffAddress).then((coordinates) {
          setState(() {
            _dropoffLocation = coordinates;
          });
        });
      } else {
        print("No hay viaje actual");
      }
    } catch (e) {
      print('Error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Info"),
      ),
      body: tripsito == null
          ? const Center(
              // Display a message when there is no current trip
              child: Text(
                'No current trip',
                style: TextStyle(fontSize: 16),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    height: 200, // Set the desired height for the map
                    margin: EdgeInsets.all(8),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition:
                          CameraPosition(target: _bogota, zoom: 5),
                      markers: {
                        Marker(
                          markerId: MarkerId('Pickup'),
                          position: _pickupLocation,
                          infoWindow: InfoWindow(title: 'Pickup Address'),
                        ),
                        Marker(
                          markerId: MarkerId('Dropoff'),
                          position: _dropoffLocation,
                          infoWindow: InfoWindow(title: 'Dropoff Address'),
                        ),
                      },
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      color: const Color.fromARGB(255, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Load Type: ${load?.type}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2000000477 * ffem / fem,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color)),
                          Text('Trailer Type: ${load?.trailerType ?? "N/A"}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2000000477 * ffem / fem,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color)),
                          Text('Weight: ${load?.weight ?? "N/A"} lbs',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2000000477 * ffem / fem,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color)),
                          if (load?.volume != null)
                            Text('Volume: ${load?.volume} cubic ft',
                                style: GoogleFonts.montserrat(
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2000000477 * ffem / fem,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color)),
                          Text(
                              'Pickup Address: ${pickup?.address}, ${pickup?.city}, ${pickup?.country}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2000000477 * ffem / fem,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color)),
                          Text(
                              'Dropoff Address: ${dropoff?.address}, ${dropoff?.city}, ${dropoff?.country}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2000000477 * ffem / fem,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25 * ffem),
                ElevatedButton(
                  onPressed: () {
                    if (ConnectivityController.hasInternet) {
                      updateTripStatus(tripsito!.id);
                    } else {
                      CustomAlertDialog.showAlertDialog(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Background color
                    onPrimary: Colors.white, // Text color
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Terminar Envio',
                    style: GoogleFonts.montserrat(
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w600,
                      color: Colors.white, // Text color
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

Future<LatLng> getCoordinatesFromAddress(String address) async {
  print(address);
  try {
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      final location = locations[0];
      print(location.latitude);
      return LatLng(location.latitude, location.longitude);
    }
  } catch (e) {
    print("Error :  $e");
  }

  return LatLng(0.0, 0.0); // Default position if address not found
}

// Función para actualizar el estado del viaje
Future<void> updateTripStatus(int id) async {
  try {
    // Realiza una solicitud PUT o POST a tu endpoint de actualización de estado
    final response = await http.put(
      Uri.parse('$trips/updateStatus/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // Verifica si la solicitud fue exitosa (código de estado 200)
    if (response.statusCode == 200) {
      // Muestra un mensaje o realiza otras acciones si es necesario
      print('Estado del viaje actualizado con éxito');
    } else {
      // Maneja el caso en el que la solicitud no fue exitosa
      print('Error al actualizar el estado del viaje: ${response.body}');
    }
  } catch (e) {
    // Maneja errores de red u otros errores
    print('Error al realizar la solicitud: $e');
  }
}

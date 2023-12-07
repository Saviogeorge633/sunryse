import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:http/http.dart' as http;

class Auto extends StatelessWidget {
    Future<void> fetchDataAndSend(BuildContext context) async {
        // Fetch data from the weather API
        final response = await http.get(
            Uri.parse(
                    'http://api.weatherapi.com/v1/forecast.json?key=c0504a01e0214430ae3150810230111&q=Sheffield&days=1&aqi=no&alerts=no'),
        );

        if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            final forecast = data['forecast']['forecastday'][0]['day'];

            // Send the data to the Flask app
            final resultResponse = await http.post(
                Uri.parse('http://172.22.39.28:5000/predict'),
                headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(<String, String>{
                    'maxTemp': forecast['maxtemp_c'].toString(),
                    'minTemp': forecast['mintemp_c'].toString(),
                    'avgTemp': forecast['avgtemp_c'].toString(),
                    'maxWindSpeed': forecast['maxwind_kph'].toString(),
                    'totalPrecipitation': forecast['totalprecip_in'].toString(),
                    'avgVisibility': forecast['avgvis_km'].toString(),
                    'avgHumidity': forecast['avghumidity'].toString(),
                    'uv': forecast['uv'].toString(),
                }),
            );

            if (resultResponse.statusCode == 200) {
                final result = jsonDecode(resultResponse.body)['result'];
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Result'),
                            content: Text('The Amount of Solar Energy generated is: $result MegaWatts'),
                            actions: <Widget>[
                                TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                        Navigator.of(context).pop();
                                    },
                                ),
                            ],
                        );
                    },
                );
            } else {
                throw Exception('Failed to send data');
            }
        } else {
            throw Exception('Failed to fetch data');
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
                title: DefaultTextStyle(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato',
                    ),
                    child: Text('Auto'),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
            ),
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SlideAction(
                        innerColor: Colors.black,
                        outerColor: Colors.grey[200],
                        sliderButtonIcon: Icon(Icons.lock_open, color: Colors.white),
                        text: 'Slide for prediction',
                        textStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                        onSubmit: () => fetchDataAndSend(context),
                    ),
                ),
            ),
        );
    }
}


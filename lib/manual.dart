import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
    runApp(Manual());
}

class Manual extends StatelessWidget {
    final maxTempController = TextEditingController();
    final minTempController = TextEditingController();
    final avgTempController = TextEditingController();
    final maxWindSpeedController = TextEditingController();
    final totalPrecipitationController = TextEditingController();
    final avgVisibilityController = TextEditingController();
    final avgHumidityController = TextEditingController();
    final uvController = TextEditingController();

    Future<void> sendData(BuildContext context) async {
        final response = await http.post(
            Uri.parse('http://172.22.39.28:5000/predict'),
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
                'maxTemp': maxTempController.text,
                'minTemp': minTempController.text,
                'avgTemp': avgTempController.text,
                'maxWindSpeed': maxWindSpeedController.text,
                'totalPrecipitation': totalPrecipitationController.text,
                'avgVisibility': avgVisibilityController.text,
                'avgHumidity': avgHumidityController.text,
                'uv': uvController.text,
            }),
        );

        if (response.statusCode == 200) {
            // If the server returns a 200 OK response,
            // then parse the JSON.
            final result = jsonDecode(response.body)['result'];
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
            showDialog(
                context: context,
                builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text('Error'),
                        content: Text('Invalid data entered'),
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
        }
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                    title: DefaultTextStyle(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                        ),
                        child: Text('Manual'),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                ),
                body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                        child: Column(
                            children: <Widget>[
                                SizedBox(height: 10),
                                TextFormField(
                                    controller: maxTempController,
                                    decoration: InputDecoration(labelText: 'Max Temperature', filled: true, fillColor: Colors.white,),
                                    style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                    controller: minTempController,
                                    decoration: InputDecoration(labelText: 'Min Temperature', filled: true, fillColor: Colors.white,),
                                    style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                    controller: avgTempController,
                                    decoration: InputDecoration(labelText: 'Average Temperature', filled: true, fillColor: Colors.white,),
                                    style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                    controller: maxWindSpeedController,
                                    decoration: InputDecoration(labelText: 'Max WindSpeed', filled: true, fillColor: Colors.white,),
                                    style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                    controller: totalPrecipitationController,
                                    decoration: InputDecoration(labelText: 'Total Precipitation', filled: true, fillColor: Colors.white,),
                                    style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                    controller: avgVisibilityController,
                                    decoration: InputDecoration(labelText: 'Avg Visibility', filled: true, fillColor: Colors.white,),
                                    style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                    controller: avgHumidityController,
                                    decoration: InputDecoration(labelText: 'Avg Humidity', filled: true, fillColor: Colors.white,),
                                    style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                    controller: uvController,
                                    decoration: InputDecoration(labelText: 'UV', filled: true, fillColor: Colors.white,),
                                    style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () => sendData(context),
                                    child: Text('Send Data'),
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}
import 'package:ana_weather/model/databse_helper.dart';
import 'package:ana_weather/screen/ana_weather.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;

  LocationData? _locationData = await getLocation();
  runApp(MyApp(locationData: _locationData));
}

Future<LocationData?> getLocation() async {
  Location location = new Location();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  _locationData = await location.getLocation();
  return _locationData;
}

class MyApp extends StatelessWidget {
  MyApp({this.locationData});
  final LocationData? locationData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ANAWeatherPage(
          title: 'ANA SIMPLE WEATHER APP', locationData: locationData),
    );
  }
}

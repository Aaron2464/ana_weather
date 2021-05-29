import 'package:ana_weather/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ANAWeatherPage(title: 'ANA SIMPLE WEATHER APP'),
    );
  }
}

class ANAWeatherPage extends StatefulWidget {
  ANAWeatherPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ANAWeatherPageState createState() => _ANAWeatherPageState();
}

class _ANAWeatherPageState extends State<ANAWeatherPage> {
  WeatherBloc _weatherBloc = WeatherBloc();

  @override
  void initState() {
    super.initState();
    _weatherBloc.getCityWeather('Taipei');
    _weatherBloc.getLocationWeather(25.0, 120.5319);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add City',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    super.dispose();
    _weatherBloc.dispose();
  }
}

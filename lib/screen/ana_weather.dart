import 'package:ana_weather/beans/location_bean/location_weather_bean.dart';
import 'package:ana_weather/beans/weather_bean/weather_bean.dart';
import 'package:ana_weather/bloc/weather_bloc.dart';
import 'package:ana_weather/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class ANAWeatherPage extends StatefulWidget {
  ANAWeatherPage({Key? key, required this.title, this.locationData})
      : super(key: key);
  final String title;
  final LocationData? locationData;

  @override
  _ANAWeatherPageState createState() => _ANAWeatherPageState();
}

class _ANAWeatherPageState extends State<ANAWeatherPage> {
  WeatherBloc _weatherBloc = WeatherBloc();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.locationData != null)
      _weatherBloc.getLocationWeather(
          widget.locationData!.latitude!, widget.locationData!.longitude!);

    _weatherBloc.getWeathers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.lightBlueAccent,
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: _weatherBloc.locationWeatherFetcher,
              builder: (BuildContext context,
                  AsyncSnapshot<LocationWeatherBean> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: weatherRow(
                        src:
                            '$iconUrl/${snapshot.data!.list?[0].weather?[0].icon}@2x.png',
                        city: snapshot.data!.list![0].name ?? '',
                        temp: snapshot.data!.list![0].main!.temp!),
                  );
                }
                return SizedBox();
              },
            ),
            Expanded(
              child: StreamBuilder(
                stream: _weatherBloc.cityWeathersFetcher,
                builder: (BuildContext context,
                    AsyncSnapshot<List<WeatherBean>> snapshot) {
                  if (snapshot.hasData && snapshot.data!.length != 0)
                    return Container(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: index % 2 == 0
                                ? Colors.white60
                                : Colors.transparent,
                            child: weatherRow(
                                src:
                                    '$iconUrl/${snapshot.data![index].icon}@2x.png',
                                city: snapshot.data![index].city ?? '',
                                temp: snapshot.data![index].temp!),
                          );
                        },
                      ),
                    );

                  return Center(
                    child: FittedBox(
                      child: Text(
                        'Press \" + \" add city\'s weather',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Container(
                  padding:
                      EdgeInsets.only(left: 20, top: 65, right: 20, bottom: 20),
                  margin: EdgeInsets.only(top: 45),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(offset: Offset(0, 5), blurRadius: 10),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Add city you\'d like to see the weather',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      TextField(
                          controller: textEditingController,
                          textAlign: TextAlign.center),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _weatherBloc
                                  .getCityWeather(textEditingController.text);
                              textEditingController.text = '';
                              Navigator.of(context).pop();
                            },
                            child: Text('Add'),
                          ),
                          SizedBox(width: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        tooltip: 'Add City',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _weatherBloc.dispose();
  }

  Widget weatherRow(
      {required String src, required String city, required double temp}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.network(src),
        Text(
          city,
          style: TextStyle(fontSize: 24.0),
          overflow: TextOverflow.ellipsis,
        ),
        Text('${(temp - 273.15).toStringAsFixed(1)} °C',
            style: TextStyle(fontSize: 24.0)),
      ],
    );
  }
}

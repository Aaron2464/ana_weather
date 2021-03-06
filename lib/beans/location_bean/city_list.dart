import 'package:ana_weather/beans/global/clouds.dart';
import 'package:ana_weather/beans/global/coord.dart';
import 'package:ana_weather/beans/global/main_wether.dart';
import 'package:ana_weather/beans/global/sys.dart';
import 'package:ana_weather/beans/global/weather.dart';
import 'package:ana_weather/beans/global/wind.dart';

class CityList {
  int? id;
  String? name;
  Coord? coord;
  MainWeather? main;
  int? dt;
  Wind? wind;
  Sys? sys;
  dynamic rain;
  dynamic snow;
  Clouds? clouds;
  List<Weather>? weather;

  CityList(
      {this.id,
      this.name,
      this.coord,
      this.main,
      this.dt,
      this.wind,
      this.sys,
      this.rain,
      this.snow,
      this.clouds,
      this.weather});

  CityList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    main = json['main'] != null ? new MainWeather.fromJson(json['main']) : null;
    dt = json['dt'];
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    rain = json['rain'];
    snow = json['snow'];
    clouds =
        json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null;
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.coord != null) {
      data['coord'] = this.coord!.toJson();
    }
    if (this.main != null) {
      data['main'] = this.main!.toJson();
    }
    data['dt'] = this.dt;
    if (this.wind != null) {
      data['wind'] = this.wind!.toJson();
    }
    if (this.sys != null) {
      data['sys'] = this.sys!.toJson();
    }
    data['rain'] = this.rain;
    data['snow'] = this.snow;
    if (this.clouds != null) {
      data['clouds'] = this.clouds!.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

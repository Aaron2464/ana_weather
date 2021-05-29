import 'package:ana_weather/beans/location_bean/city_list.dart';

class LocationWeatherBean {
  String? message;
  dynamic cod;
  int? count;
  List<CityList>? list;

  LocationWeatherBean({this.message, this.cod, this.count, this.list});

  LocationWeatherBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    cod = json['cod'];
    count = json['count'];
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list!.add(new CityList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['cod'] = this.cod;
    data['count'] = this.count;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

import 'dart:convert';

import 'package:ana_weather/beans/city_bean/city_weather_bean.dart';
import 'package:ana_weather/beans/location_bean/LocationWeatherBean.dart';
import 'package:ana_weather/utilities/constants.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  Future fetchLocationWeather(
      {required double lat, required double lon}) async {
    http.Response response = await http.get(
        Uri.parse('$weatherApi/find?lat=$lat&lon=$lon&cnt=1&appid=$apiKey'));
    final parse = json.decode(response.body);
    return LocationWeatherBean.fromJson(parse);
  }

  Future fetchCityWeather({required String city}) async {
    http.Response response =
        await http.get(Uri.parse('$weatherApi/weather?q=$city&appid=$apiKey'));
    final parse = json.decode(response.body);
    return CityWeatherBean.fromJson(parse);
  }
}

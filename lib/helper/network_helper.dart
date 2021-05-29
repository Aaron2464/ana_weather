import 'dart:convert';

import 'package:ana_weather/beans/city_bean/city_weather_bean.dart';
import 'package:ana_weather/beans/location_bean/location_weather_bean.dart';
import 'package:ana_weather/beans/weather_bean/weather_bean.dart';
import 'package:ana_weather/model/weather_model.dart';
import 'package:ana_weather/utilities/constants.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  WeatherModel _weatherModel = WeatherModel();

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
    CityWeatherBean bean = CityWeatherBean.fromJson(parse);
    if (response.statusCode == 200) {
      _weatherModel.insertWeather(WeatherBean(
          city: bean.name, temp: bean.main!.temp, icon: bean.weather![0].icon));
    }
    return bean;
  }
}

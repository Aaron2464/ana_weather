import 'package:ana_weather/beans/city_bean/city_weather_bean.dart';
import 'package:ana_weather/beans/location_bean/LocationWeatherBean.dart';
import 'package:ana_weather/network_helper/NetworkHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc {
  NetworkHelper _networkHelper = NetworkHelper();

  final _cityWeatherFetcher = PublishSubject<CityWeatherBean>();
  final _locationWeatherFetcher = PublishSubject<LocationWeatherBean>();

  Stream<CityWeatherBean> get cityWeatherFetcher => _cityWeatherFetcher.stream;
  Stream<LocationWeatherBean> get locationWeatherFetcher =>
      _locationWeatherFetcher.stream;

  getLocationWeather(double lat, double lon) async {
    LocationWeatherBean result = await _networkHelper.fetchLocationWeather(
      lat: lat,
      lon: lon,
    );

    print(result.toJson());
    if (result.cod == 200)
      _locationWeatherFetcher.sink.add(result);
    else
      Fluttertoast.showToast(
          msg: result.message ?? 'Oops, something wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
  }

  getCityWeather(String city) async {
    CityWeatherBean result = await _networkHelper.fetchCityWeather(city: city);
    if (result.cod == 200)
      _cityWeatherFetcher.sink.add(result);
    else
      Fluttertoast.showToast(
          msg: result.message ?? 'Oops, something wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
  }

  dispose() {
    _cityWeatherFetcher.close();
    _locationWeatherFetcher.close();
  }
}

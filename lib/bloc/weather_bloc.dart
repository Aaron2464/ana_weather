import 'package:ana_weather/beans/city_bean/city_weather_bean.dart';
import 'package:ana_weather/beans/location_bean/location_weather_bean.dart';
import 'package:ana_weather/beans/weather_bean/weather_bean.dart';
import 'package:ana_weather/model/weather_model.dart';
import 'package:ana_weather/network_helper/NetworkHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc {
  NetworkHelper _networkHelper = NetworkHelper();

  final _cityWeathersFetcher = PublishSubject<List<WeatherBean>>();
  final _locationWeatherFetcher = PublishSubject<LocationWeatherBean>();

  Stream<List<WeatherBean>> get cityWeathersFetcher =>
      _cityWeathersFetcher.stream;
  Stream<LocationWeatherBean> get locationWeatherFetcher =>
      _locationWeatherFetcher.stream;

  getWeathers() async {
    List<WeatherBean> bean = await WeatherModel().weathers();
    _cityWeathersFetcher.sink.add(bean);
  }

  getLocationWeather(double lat, double lon) async {
    LocationWeatherBean result = await _networkHelper.fetchLocationWeather(
      lat: lat,
      lon: lon,
    );

    if (int.parse(result.cod) == 200) {
      _locationWeatherFetcher.sink.add(result);
    } else
      Fluttertoast.showToast(
          msg: result.message ?? 'Oops, something wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
  }

  getCityWeather(String city) async {
    CityWeatherBean result = await _networkHelper.fetchCityWeather(city: city);
    if (result.cod == 200) {
      getWeathers();
    } else
      Fluttertoast.showToast(
          msg: result.message ?? 'Oops, something wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
  }

  dispose() {
    _cityWeathersFetcher.close();
    _locationWeatherFetcher.close();
  }
}

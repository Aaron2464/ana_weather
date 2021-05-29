import 'package:ana_weather/beans/weather_bean/weather_bean.dart';
import 'package:ana_weather/model/databse_helper.dart';
import 'package:sqflite/sqflite.dart';

class WeatherModel {
  Future<void> insertWeather(WeatherBean bean) async {
    final db = await DatabaseHelper.instance.database;
    await db!.insert('WEATHER', bean.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<WeatherBean>> weathers() async {
    final db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> maps = await db!.query('WEATHER');

    return List.generate(maps.length, (i) {
      return WeatherBean(
        city: maps[i]['city'],
        temp: double.parse(maps[i]['temp']),
        icon: maps[i]['icon'],
      );
    });
  }

  Future<void> updateWeather(WeatherBean bean) async {
    final db = await DatabaseHelper.instance.database;
    await db!.update(
      'WEATHER',
      bean.toJson(),
      where: 'city = ?',
      whereArgs: [bean.city],
    );
  }

  Future<void> deleteWeather(String city) async {
    final db = await DatabaseHelper.instance.database;
    await db!.delete(
      'WEATHER',
      where: 'city = ?',
      whereArgs: [city],
    );
  }
}

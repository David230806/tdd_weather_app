import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_tdd/core/constants/constants.dart';
import 'package:weather_tdd/core/error/exception.dart';
import 'package:weather_tdd/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final Client client;
  WeatherRemoteDataSourceImpl({required this.client});
  
  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response = await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));

    if(response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_tdd/data/models/weather_model.dart';
import 'package:weather_tdd/domain/entities/weather.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: "America/Chicago",
    description: "broken clouds",
    humidity: 89,
    iconCode: '04d',
    main: "Clouds",
    pressure: 1014,
    temperature: 292.55,
  );

  test("should be a subclass of weather entity", () async {
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test("should return a valid model from json", () async {
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_weather_response.json'),
    );

    final result = WeatherModel.fromJson(jsonMap);

    expect(result, equals(testWeatherModel));
  });

  test("should return a json map containing proper data", () async {
    final result = testWeatherModel.toJson();

    final expectedJsonMap = {
      "timezone": "America/Chicago",
      "current": {
        "temp": 292.55,
        "humidity": 89,
        "pressure": 1014,
        "weather": [
          {
            "main": "Clouds",
            "description": "broken clouds",
            "icon": '04d',
          }
        ],
      }
    };

    expect(result, expectedJsonMap);
  });
}

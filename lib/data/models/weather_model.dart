import 'package:weather_tdd/domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.main,
    required super.description,
    required super.iconCode,
    required super.temperature,
    required super.pressure,
    required super.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        cityName: "",
        main: json['current']['weather'][0]['main'],
        description: json['current']['weather'][0]['description'],
        iconCode: json['current']['weather'][0]['icon'],
        temperature: json['current']['temp'],
        pressure: json['current']['pressure'],
        humidity: json['current']['humidity'],
      );

  Map<String, dynamic> toJson() => {
        "timezone": cityName,
        "current": {
          "temp": temperature,
          "humidity": humidity,
          "pressure": pressure,
          "weather": [
            {
              "main": main,
              "description": description,
              "icon": iconCode,
            }
          ],
        }
      };

  WeatherEntity toEntity() => WeatherEntity(
        cityName: cityName,
        main: main,
        description: description,
        iconCode: iconCode,
        temperature: temperature,
        pressure: pressure,
        humidity: humidity,
      );
}

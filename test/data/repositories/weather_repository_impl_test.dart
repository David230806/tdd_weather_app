import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_tdd/core/error/exception.dart';
import 'package:weather_tdd/core/error/failure.dart';
import 'package:weather_tdd/data/models/weather_model.dart';
import 'package:weather_tdd/data/repositories/weather_repository_impl.dart';
import 'package:weather_tdd/domain/entities/weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();

    weatherRepositoryImpl = WeatherRepositoryImpl(
      weatherRemoteDataSource: mockWeatherRemoteDataSource,
    );
  });

  const testWeatherEntity = WeatherEntity(
    cityName: "America/Chicago",
    description: "broken clouds",
    humidity: 89,
    iconCode: '04d',
    main: "Clouds",
    pressure: 1014,
    temperature: 292.55,
  );

  const testWeatherModel = WeatherModel(
    cityName: "America/Chicago",
    description: "broken clouds",
    humidity: 89,
    iconCode: '04d',
    main: "Clouds",
    pressure: 1014,
    temperature: 292.55,
  );

  const testCityName = "America/Chicago";

  group("get current weather", () {
    test('should return current weather when a call to data source is success',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);

      //act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      //assert
      expect(result, equals(const Right(testWeatherEntity)));
    });

    test('should return server failure when a call to data source is unsuccess',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(ServerException());

      //act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      //assert
      expect(result, equals(const Left(ServerFailure("An error has occured"))));
    });

    test(
        'should return connection failure when a call to data source is unsuccess',
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(SocketException());

      //act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      print(result);

      //assert
      expect(
          result,
          equals(const Left(
              ConnectionFailure("Failed to connect to the network"))));
    });
  });
}

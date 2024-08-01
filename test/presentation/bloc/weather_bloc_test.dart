import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_tdd/core/error/failure.dart';
import 'package:weather_tdd/domain/entities/weather.dart';
import 'package:weather_tdd/presentation/bloc/weather_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

  const testWeather = WeatherEntity(
    cityName: "America/Chicago",
    description: "broken clouds",
    humidity: 89,
    iconCode: '04d',
    main: "Clouds",
    pressure: 1014,
    temperature: 292.55,
  );

  const testCityName = "America/Chicago";

  test('initial state should be empty', () {
    //assert
    expect(weatherBloc.state, WeatherInitial());
  });

  blocTest<WeatherBloc, WeatherState>(
    'emits [WeatherLoading, WeatherLoaded] when data is gotten successfully.',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async => const Right(testWeather));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => <WeatherState>[
      WeatherLoading(),
      const WeatherLoaded(testWeather),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'emits [WeatherLoading, WeatherLoaded] when get data is unsuccess.',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async => const Left(ServerFailure("Server failure")));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => <WeatherState>[
      WeatherLoading(),
      const WeatherLoadFailed('Server failure'),
    ],
  );
}

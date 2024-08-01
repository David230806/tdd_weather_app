import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:weather_tdd/data/data_sources/remote_data_source.dart';
import 'package:weather_tdd/data/repositories/weather_repository_impl.dart';
import 'package:weather_tdd/domain/repositories/weather_repository.dart';
import 'package:weather_tdd/domain/usecases/get_current_weather.dart';
import 'package:weather_tdd/presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => WeatherBloc(locator()));

  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherRemoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton(() => Client());
}

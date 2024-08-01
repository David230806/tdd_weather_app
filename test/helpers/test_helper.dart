import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:weather_tdd/data/data_sources/remote_data_source.dart';
import 'package:weather_tdd/domain/repositories/weather_repository.dart';
import 'package:weather_tdd/domain/usecases/get_current_weather.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase,
  ],
  customMocks: [MockSpec<Client>(as: #MockHttpClient)],
)

void main() {
  
}
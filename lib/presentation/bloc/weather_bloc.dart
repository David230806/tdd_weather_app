import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_tdd/domain/entities/weather.dart';
import 'package:weather_tdd/domain/usecases/get_current_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherInitial()) {
    on<OnCityChanged>(
      _onCityChanged,
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }

  _onCityChanged(OnCityChanged event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    final result = await _getCurrentWeatherUseCase.execute(event.cityName);

    result.fold((failed) {
      emit(WeatherLoadFailed(failed.message));
    }, (data) {
      emit(WeatherLoaded(data));
    });
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

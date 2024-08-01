part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLoaded extends WeatherState {
  final WeatherEntity weather;

  const WeatherLoaded(this.weather);

  @override
  List<Object?> get props => [weather];
}

final class WeatherLoadFailed extends WeatherState {
  final String message;

  const WeatherLoadFailed(this.message);

  @override
  List<Object?> get props => [message];
}

import 'package:weather_app/model/weather_model.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weatherData;
  WeatherLoadedState(this.weatherData);
}

class WeatherLoadingFailureState extends WeatherState {
  final String error;
  WeatherLoadingFailureState(this.error);
}

abstract class WeatherEvent {}

class FetchWeatherEvent extends WeatherEvent {
  final String location;

  FetchWeatherEvent(this.location);
}

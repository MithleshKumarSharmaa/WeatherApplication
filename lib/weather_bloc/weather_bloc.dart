import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/api_service.dart';
import 'package:weather_app/data/remote_service.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/weather_bloc/weather_event.dart';
import 'package:weather_app/weather_bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final RemoteService _apiService = ApiService();

  WeatherBloc() : super(WeatherInitialState()) {
    on<FetchWeatherEvent>((event, emit) => _fetchWeatherData(event, emit));
  }

  Future<void> _fetchWeatherData(
      FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoadingState());
      final response = await _apiService.getWeatherData(event.location);
      if (response.statusCode == 200) {
        WeatherModel weatherModel =
            WeatherModel.fromJson(jsonDecode(response.body));
        emit(WeatherLoadedState(weatherModel));
      } else if (response.statusCode == 404) {
        final data = jsonDecode(response.body);
        emit(WeatherLoadingFailureState(data['message']));
      } else if (response.statusCode == 429) {
        emit(WeatherLoadingFailureState('Limit crossed'));
      } else {
        emit(
            WeatherLoadingFailureState('Unknown error ${response.statusCode}'));
      }
    } catch (error) {
      emit(WeatherLoadingFailureState('Unable to fetch weather data'));
      debugPrint('_fetchWeatherDataError: $error');
    }
  }
}

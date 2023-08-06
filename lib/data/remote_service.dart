import 'package:http/http.dart';

abstract class RemoteService {
  Future<Response> getWeatherData(String location);
}

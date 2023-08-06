import 'package:http/http.dart';
import 'package:weather_app/data/remote_service.dart';
import 'package:weather_app/remote.urls.dart';

class ApiService extends RemoteService {
  @override
  Future<Response> getWeatherData(String location) async {
    Map<String, String> queryParameters = {
      'q': location,
      'appid': '372023e1efe6254807699d8f5a21c619',
      'units': 'metric',
    };

    final response = await get(
        Uri.https(RemoteUrls.baseUrl, RemoteUrls.endPoint, queryParameters));

    return response;
  }
}

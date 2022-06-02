import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tp_weather/models/weather_report.dart';

String appId = "71f5d5afc9b2c06145fcd1fc6a45a62a";

Future<WeatherReport> getCurrentWeather(String city) async {
  List<Weather> listWeather = [];

  if (city.isEmpty) return WeatherReport(listWeather, Main("", 0), Wind(0));

  final queryParameters = {'q': city, 'appid': appId};

  var url =
      Uri.https("api.openweathermap.org", "/data/2.5/weather", queryParameters);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    for (var data in jsonResponse["weather"]) {
      Weather weather = Weather(data["main"], data["icon"]);
      listWeather.add(weather);
    }
    Main main = Main(
        "${jsonResponse["main"]["temp"]}°", jsonResponse["main"]["humidity"]);
    Wind wind = Wind(jsonResponse["wind"]["speed"]);
    return WeatherReport(listWeather, main, wind);
  } else {
    // ignore: avoid_print
    print('Request failed with status: ${response.statusCode}.');
  }
  return WeatherReport(listWeather, Main("", 0), Wind(0));
}

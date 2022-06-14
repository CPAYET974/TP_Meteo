import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tp_weather/models/weather_report.dart';
import 'package:intl/intl.dart';

const String appId = "71f5d5afc9b2c06145fcd1fc6a45a62a";

Future<CurrentWeather> getCurrentWeather(String city) async {
  List<Weather> listWeather = [];

  if (city.isEmpty) {
    return CurrentWeather(Coord(0, 0), listWeather, Main("", ""), Wind(""),
        DateTime.fromMillisecondsSinceEpoch(0).toString());
  }

  final queryParameters = {
    "q": city,
    "appid": appId,
    "units": "metric",
    "lang": "FR"
  };

  var url =
      Uri.https("api.openweathermap.org", "/data/2.5/weather", queryParameters);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    Coord coord =
        Coord(jsonResponse["coord"]["lon"], jsonResponse["coord"]["lat"]);
    for (var data in jsonResponse["weather"]) {
      Weather weather = Weather(data["main"], data["icon"]);
      listWeather.add(weather);
    }
    Main main = Main("${jsonResponse["main"]["temp"]}°",
        "${jsonResponse["main"]["humidity"]} %");
    Wind wind = Wind("${jsonResponse["wind"]["speed"]} km/h");
    String dt = DateFormat("EEEE\nd MMM, yyyy\nHH:mm")
        .format(DateTime.fromMillisecondsSinceEpoch(jsonResponse["dt"] * 1000));
    return CurrentWeather(coord, listWeather, main, wind, dt);
  } else {
    // ignore: avoid_print
    print('Request failed with status: ${response.statusCode}.');
  }
  return CurrentWeather(Coord(0, 0), listWeather, Main("", ""), Wind(""),
      DateTime.fromMillisecondsSinceEpoch(0).toString());
}

Future<DailyWeather> getDailyWeather(double lon, double lat) async {
  List<Daily> listDaily = [];
  List<Weather> listWeather = [];

  // if (lat == null && lon == null) {
  //   return DailyWeather(listDaily);
  // }

  final queryParameters = {
    "lat": lat.toString(),
    "lon": lon.toString(),
    "exclude": "current,minutely,hourly,alerts",
    "appid": appId,
    "units": "metric",
    "lang": "FR"
  };

  var url =
      Uri.https("api.openweathermap.org", "/data/2.5/onecall", queryParameters);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    for (var data in jsonResponse["daily"]) {
      String dt = DateFormat("EEEE, d MMM, yyyy")
          .format(DateTime.fromMillisecondsSinceEpoch(data["dt"] * 1000));
      for (var data2 in data["weather"]) {
        Weather weather = Weather("", data2["icon"]);
        listWeather.add(weather);
      }
      Temp temp = Temp("${data["temp"]["day"]}°");
      Daily daily = Daily(dt, listWeather, temp);
      listDaily.add(daily);
    }
    return DailyWeather(listDaily);
  } else {
    // ignore: avoid_print
    print('Request failed with status: ${response.statusCode}.');
  }
  return DailyWeather(listDaily);
}

Future<HourlyWeather> getHourlyWeather(double lon, double lat) async {
  List<Hourly> listHourly = [];
  List<Weather> listWeather = [];
  int count = 0;

  // if (lat == null && lon == null) {
  //   return DailyWeather(listDaily);
  // }

  final queryParameters = {
    "lat": lat.toString(),
    "lon": lon.toString(),
    "exclude": "current,minutely,daily,alerts",
    "appid": appId,
    "units": "metric",
    "lang": "FR"
  };

  var url =
      Uri.https("api.openweathermap.org", "/data/2.5/onecall", queryParameters);
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    for (var data in jsonResponse["hourly"]) {
      String dt = DateFormat("HH:mm")
          .format(DateTime.fromMillisecondsSinceEpoch(data["dt"] * 1000));
      for (var data2 in data["weather"]) {
        Weather weather = Weather("", data2["icon"]);
        listWeather.add(weather);
      }
      String temp = "${data["temp"]}°";
      Hourly hourly = Hourly(dt, listWeather, temp);
      listHourly.add(hourly);
      count++;
      if (count > 12) {
        break;
      }
    }
    return HourlyWeather(listHourly);
  } else {
    // ignore: avoid_print
    print('Request failed with status: ${response.statusCode}.');
  }
  return HourlyWeather(listHourly);
}

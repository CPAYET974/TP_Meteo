class CurrentWeather {
  Coord coord;
  List<Weather> weather;
  Main main;
  Wind wind;
  String dt;

  CurrentWeather(this.coord, this.weather, this.main, this.wind, this.dt);
}

class DailyWeather {
  List<Daily> daily;

  DailyWeather(this.daily);
}

class HourlyWeather {
  List<Hourly> hourly;

  HourlyWeather(this.hourly);
}

class Daily {
  String dt;
  List<Weather> weather;
  Temp temp;

  Daily(this.dt, this.weather, this.temp);
}

class Hourly {
  String dt;
  List<Weather> weather;
  String temp;

  Hourly(this.dt, this.weather, this.temp);
}

class Temp {
  String day;

  Temp(this.day);
}

class Coord {
  double lon;
  double lat;

  Coord(this.lon, this.lat);
}

class Weather {
  String main;
  String icon;

  Weather(this.main, this.icon);
}

class Main {
  String temp;
  String humidity;

  Main(this.temp, this.humidity);
}

class Wind {
  String speed;

  Wind(this.speed);
}

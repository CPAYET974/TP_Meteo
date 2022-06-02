class WeatherReport {
  List<Weather> weather;
  Main main;
  Wind wind;

  WeatherReport(this.weather, this.main, this.wind);
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

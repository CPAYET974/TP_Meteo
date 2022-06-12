// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:tp_weather/services/weather.dart';

import '../models/weather_report.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://i.ibb.co/Y2CNM8V/new-york.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Foreground()
      ],
    );
  }
}

class Foreground extends StatelessWidget {
  const Foreground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          centerTitle: true,
          title: const Text('Paris')),
      body: FutureBuilder<CurrentWeather>(
        future: getCurrentWeather("Paris"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Chargement en cours..."));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.transparent,
                      elevation: 10,
                      // ignore: prefer_const_constructors
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data!.dt.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 150,
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      color: Colors.white70,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(
                                              "http://openweathermap.org/img/wn/${snapshot.data!.weather[0].icon}@2x.png"),
                                          Text(
                                            snapshot.data!.weather[0].main,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data!.main.temp,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                Text(
                                  "Humidité : ${snapshot.data!.main.humidity}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                Text(
                                  "Vent : ${snapshot.data!.wind.speed}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  child: FutureBuilder<HourlyWeather>(
                    future: getHourlyWeather(
                        snapshot.data!.coord.lon, snapshot.data!.coord.lat),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: Text("Chargement en cours..."));
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return ListView.builder(
                          itemCount: snapshot.data!.hourly.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            return SizedBox(
                              width: 110,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.white70, width: 2),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.hourly[i].dt
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Image.network(
                                            "http://openweathermap.org/img/wn/${snapshot.data!.hourly[i].weather[0].icon}@2x.png"),
                                        Text(
                                          snapshot.data!.hourly[i].temp,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      ]),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Text("Une erreur est survenue");
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 300,
                  child: FutureBuilder<DailyWeather>(
                    future: getDailyWeather(
                        snapshot.data!.coord.lon, snapshot.data!.coord.lat),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: Text("Chargement en cours..."));
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.daily.length,
                            itemBuilder: (context, i) {
                              return SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(25, 0, 25, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshot.data!.daily[i].dt
                                            .toString()),
                                        Image.network(
                                            "http://openweathermap.org/img/wn/${snapshot.data!.daily[i].weather[0].icon}@2x.png"),
                                        Text(snapshot.data!.daily[i].temp.day)
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        //Error
                        return const Text("Une erreur est survenue");
                      }
                    },
                  ),
                )
              ],
            );
          } else {
            return const Text("Une erreur est survenue");
          }
        },
      ),
    );
  }
}

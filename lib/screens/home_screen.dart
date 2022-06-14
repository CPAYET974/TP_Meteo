import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tp_weather/models/location_model.dart';
import 'package:tp_weather/screens/widgets/navigation_drawer.dart';
import 'package:tp_weather/services/database/database.dart';
import 'package:tp_weather/services/weather_api/weather.dart';

import '../models/weather_report.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  late List<Location> locationsList;
  @override
  void initState() {
    super.initState();

    refreshLocations();
  }

  @override
  void dispose() {
    LocationsDatabase.instance.close();
    super.dispose();
  }

  Future refreshLocations() async {
    setState(() => isLoading = true);

    locationsList = await LocationsDatabase.instance.read();

    setState(() => isLoading = false);
  }

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
        const Foreground(),
      ],
    );
  }
}

class Foreground extends StatefulWidget {
  const Foreground({Key? key}) : super(key: key);

  @override
  State<Foreground> createState() => _ForegroundState();
}

class _ForegroundState extends State<Foreground> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(getLocationFrom),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Icon(
                Icons.refresh,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      drawer: NavigationDrawer(),
      body: FutureBuilder<CurrentWeather>(
        future: getCurrentWeather(getLocationFrom),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitDualRing(
                color: Colors.white,
                size: 40,
                duration: Duration(milliseconds: 1200),
              ),
            );
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
                        return Center(
                          child: SpinKitDualRing(
                            color: Colors.white,
                            size: 40,
                            duration: Duration(milliseconds: 1200),
                          ),
                        );
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
                  height: 200,
                  child: FutureBuilder<DailyWeather>(
                    future: getDailyWeather(
                        snapshot.data!.coord.lon, snapshot.data!.coord.lat),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitDualRing(
                            color: Colors.white,
                            size: 40,
                            duration: Duration(milliseconds: 1200),
                          ),
                        );
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

import 'package:flutter/material.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        title: const Text(
          'Weather Home Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 8),
                // width: double.infinity,
                width: MediaQuery.of(context).size.width - 100,
                height: 150,
                color: Colors.blue,
                child: Card(
                  color: Colors.orange,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: const Center(
                    child: Text('Current Weather Data'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                color: Colors.purple[600],
                child: Center(
                  child: Card(
                    color: Colors.orange,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const Center(
                      child: Text('Current Weather Data'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 60,
                width: 400,
                color: Colors.blueGrey,
                child: const Text('Upcoming days'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tp_weather/models/location_model.dart';
import 'package:tp_weather/screens/widgets/foreground_screen.dart';
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

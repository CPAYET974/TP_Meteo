import 'package:flutter/material.dart';
import 'package:tp_weather/models/location_model.dart';
import 'package:tp_weather/screens/templates/navigation_drawer.dart';
import 'package:tp_weather/services/database/database.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
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
        centerTitle: true,
        title: const Text('Paris'),
      ),
      drawer: NavigationDrawer(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.transparent,
              elevation: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                SizedBox(
                  width: 110,
                  child: Card(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white70, width: 2),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.transparent,
                    child: const Center(
                        child: Text(
                      'Item 1',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Card(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white70, width: 2),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.transparent,
                    child: const Center(
                        child: Text(
                      'Item 2',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Card(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white70, width: 2),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.transparent,
                    child: const Center(
                        child: Text(
                      'Item 3',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Card(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white70, width: 2),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.transparent,
                    child: const Center(
                        child: Text(
                      'Item 4',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Card(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white70, width: 2),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.transparent,
                    child: const Center(
                      child: Text(
                        'Item 5',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: const <Widget>[
                Card(
                  child: ListTile(
                    title: Text("Date"),
                    subtitle: Text("Description"),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/sun.png"),
                    ),
                    trailing: Text('Température'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Date"),
                    subtitle: Text("Description"),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/sun.png"),
                    ),
                    trailing: Text('Température'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Date"),
                    subtitle: Text("Description"),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/sun.png"),
                    ),
                    trailing: Text('Température'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Date"),
                    subtitle: Text("Description"),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/sun.png"),
                    ),
                    trailing: Text('Température'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Date"),
                    subtitle: Text("Description"),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/sun.png"),
                    ),
                    trailing: Text('Température'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

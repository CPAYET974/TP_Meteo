// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
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
          SizedBox(
            height: 300,
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

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tp_weather/models/location_model.dart';
import 'package:tp_weather/services/database/database.dart';

class NavigationDrawer extends StatefulWidget {
  NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  TextEditingController locationController = TextEditingController();
  List<Widget> locationList = <Widget>[];

  static Database? _database;

  getAllLocations() async {
    var locations = await LocationsDatabase.instance.read();

    for (var element in locations) {
      setState(() {
        locationList.add(ListTile(
          title: Text(element.cityName),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      final location =
                          Location(cityName: locationController.text);
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              child: TextButton(
                child: const Text('Ajouter une ville'),
                onPressed: () {
                  openDialog(context);
                },
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: locationList,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future openDialog(BuildContext context) async {
    TextEditingController locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter une ville :'),
        content: TextField(
            controller: locationController,
            decoration: const InputDecoration(hintText: 'City name...'),
            onSubmitted: (value) async {
              final oneLocation = Location(cityName: locationController.text);
              await LocationsDatabase.instance.create(tableName, oneLocation);
            }
            // onSubmitted: VERIFIE NOM DE VILLE, STOCK EN BDD, ENVOIE API,
            ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('CLOSE'),
          )
        ],
      ),
    );
  }
}

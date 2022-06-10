import 'package:flutter/material.dart';
import 'package:tp_weather/models/location_model.dart';
import 'package:tp_weather/services/database/database.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<List<Location>>(
                future: LocationsDatabase.instance.read(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Location>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Center(
                            child: TextButton(
                              onPressed: () {
                                print('API');
                              },
                              child: Text(
                                snapshot.data![index].cityName,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.clear, color: Colors.red),
                            onPressed: () async {
                              await LocationsDatabase.instance.deleteLocation(
                                  snapshot.data![index].cityName);
                              setState(() {});
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text('No data avaible');
                  }
                },
              ),
            ),
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

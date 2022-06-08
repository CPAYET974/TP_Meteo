import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {},
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
            )
          ],
        ),
      ),
    );
  }

  Future openDialog(BuildContext context) async {
    // TextEditingController locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter une ville :'),
        content: const TextField(
          decoration: InputDecoration(hintText: 'City name...'),
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

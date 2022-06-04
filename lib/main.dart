import 'package:flutter/material.dart';
import 'package:tp_weather/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController controller = PageController();
  int _page = 1;

  void _changePageButton(int page) {
    setState(() {
      int direction = page - _page;
      controller.animateToPage(controller.page!.toInt() + direction,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      _page += direction;
    });
  }

  void _changePageScroll(int page) {
    setState(() {
      _page = page + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Column(children: [
          const Text("Titre"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3.27,
                child: TextButton(
                    onPressed: () => _changePageButton(1),
                    child: const Text(
                      "aujourd'hui",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3.27,
                child: TextButton(
                    onPressed: () => _changePageButton(2),
                    child: const Text(
                      "Demain",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3.27,
                child: TextButton(
                    onPressed: () => _changePageButton(3),
                    child: const Text(
                      "10 jours",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )),
              ),
            ],
          )
        ]),
      ),
      body: PageView(
        controller: controller,
        onPageChanged: (page) {
          _changePageScroll(page);
        },
        children: [
          page1(context),
          page2(context),
          page3(context),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget today(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(26, 13, 26, 0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "6 juin, 12:19",
          style: TextStyle(fontSize: 17.5),
        ),
        const SizedBox(
          height: 26,
        ),
        Row(
          children: const [
            Text(
              "Jour : 27°",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Icon(
              Icons.keyboard_double_arrow_up_rounded,
              size: 15,
              color: Colors.white,
            ),
            Text(
              " · Nuit : 16°",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Icon(
              Icons.keyboard_double_arrow_down_rounded,
              size: 15,
              color: Colors.white,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "26°",
              style: TextStyle(fontSize: 70, color: Colors.white),
            ),
            Icon(
              Icons.cloud,
              size: 70,
              color: Colors.white,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Température ressentie : 27°",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              "Nuageux",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        )
      ],
    ),
  );
}

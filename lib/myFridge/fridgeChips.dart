import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capstone_design_2022_spring/resources.dart';
import 'package:capstone_design_2022_spring/mainSearch.dart';

Widget fridgeChips(String ing, context) => ClipRRect(
  borderRadius: BorderRadius.circular(10),
  child: Stack(
    children: <Widget>[
      Positioned.fill(
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  light, dark
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            )
        ),
      ),
      TextButton(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          padding: const EdgeInsets.all(10.0),
          primary: Colors.white,
          textStyle: const TextStyle(fontSize: 20, letterSpacing: -1),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return mainSearch(ingName: ing);
            }),
          );
        },
        child: Center(child: Text('${ing}')),
      ),
    ],
  ),
);
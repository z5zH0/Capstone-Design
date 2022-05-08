import 'package:flutter/material.dart';

const dark = const Color(0xff38B6FC);
const regular = const Color(0xff77CEFF);
const light = const Color(0xffBCE7FF);

BoxDecoration myGradient = BoxDecoration(
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30)
    ),
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          light, dark
        ]
    )
);
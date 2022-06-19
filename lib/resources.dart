import 'package:flutter/material.dart';
import 'recipe_data.dart';
import 'dart:convert';

var recipeData = jsonDecode(recipe_data);

const dark = const Color(0xff38B6FC);
const regular = const Color(0xff77CEFF);
const light = const Color(0xffBCE7FF);

List<String> ingredients = [];
List resultRecipe = [];

List<String> myFridge = [];
List<String> myRecipe = [];

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

Widget button = Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    width: 400,
    height: 100,
    decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            light, dark
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25)
    ),
    child: ElevatedButton(
      onPressed: (){
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Text('사진 불러오기', style: TextStyle(fontSize: 30),),
    ),
  ),
);

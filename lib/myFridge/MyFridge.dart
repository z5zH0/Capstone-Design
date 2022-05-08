import 'package:flutter/material.dart';
import '../resources.dart';

class MyFridge extends StatelessWidget {
  const MyFridge({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
          title: Text('나의 냉장고', style: TextStyle(fontSize: 25.0)),
          elevation: 0.0,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: myGradient
          ),
        ),
    );
  }
}
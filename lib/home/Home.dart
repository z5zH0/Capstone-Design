import 'package:flutter/material.dart';
import '../resources.dart';
import 'Search.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8,5,8,5),
            child: search()
          ),
          ),
        elevation: 0.0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: myGradient
        ),
      ),
    );
  }
}
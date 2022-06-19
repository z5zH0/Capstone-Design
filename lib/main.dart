
import 'package:flutter/material.dart';
import 'home/Home.dart';
import 'myFridge/MyFridge.dart';
import 'option/Option.dart';
import 'package:firebase_core/firebase_core.dart';
import 'recipe_data.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDefault();
  runApp(const MyApp());
}

Future<void> initializeDefault() async {
  FirebaseApp app = await Firebase.initializeApp();
  print('Initialized default app $app');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          fontFamily: 'OpenSans',
          textTheme: TextTheme(
          subtitle1: TextStyle(letterSpacing: -0.5),
          bodyText2: TextStyle(letterSpacing: -1.0),
        )
      ),
      home: BottomNavigator(),
    );
  }
}

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {

  bool isClickedCamera = true;
  bool isClickedOption = false;
  bool isClickedFridge = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height * 0.12,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 5,
                    blurRadius: 8
                )]
            ),
            child: TabBar(
              onTap: (index){
                switch(index){
                  case 0:
                    setState(() {
                      isClickedCamera = true;
                      isClickedOption = false;
                      isClickedFridge = false;
                    });
                    break;
                  case 1:
                    setState(() {
                      isClickedCamera = false;
                      isClickedOption = true;
                      isClickedFridge = false;
                    });
                    break;
                  case 2:
                    setState(() {
                      isClickedCamera = false;
                      isClickedOption = false;
                      isClickedFridge = true;
                    });
                    break;
                }
              },
              indicatorColor: Colors.transparent,
                tabs: <Widget>[
                  Tab(
                    icon: isClickedCamera ?
                    Stack(
                      children: <Widget>[
                        Image.asset('images/Eclipse.png'),
                        Positioned(
                          top: 2,
                          bottom: 2,
                          right: 2,
                          left: 2,
                          child: ImageIcon(
                              AssetImage('images/camera_icon.png'),
                              color: Colors.white,
                              size: MediaQuery.of(context).size.height * 0.04),
                        ),
                      ],
                    ) : 
                    ImageIcon(
                      AssetImage('images/camera_icon.png'),
                      color: Colors.black,
                        size: MediaQuery.of(context).size.height * 0.05
                    )
                  ),
                  Tab(
                      icon: isClickedOption ?
                      Stack(
                        children: <Widget>[
                          Image.asset('images/Eclipse.png'),
                          Positioned(
                            top: 2,
                            bottom: 2,
                            right: 2,
                            left: 2,
                            child: ImageIcon(
                                AssetImage('images/options_icon.png'),
                                color: Colors.white,
                                size: MediaQuery.of(context).size.height * 0.04),
                          ),
                        ],
                      ) :
                      ImageIcon(
                          AssetImage('images/options_icon.png'),
                          color: Colors.black,
                          size: MediaQuery.of(context).size.height * 0.05
                      )
                  ),
                  Tab(
                      icon: isClickedFridge ?
                      Stack(
                        children: <Widget>[
                          Image.asset('images/Eclipse.png'),
                          Positioned(
                            top: 2,
                            bottom: 2,
                            right: 2,
                            left: 2,
                            child: ImageIcon(
                                AssetImage('images/fridge_icon.png'),
                                color: Colors.white,
                                size: MediaQuery.of(context).size.height * 0.04),
                          ),
                        ],
                      ) :
                      ImageIcon(
                          AssetImage('images/fridge_icon.png'),
                          color: Colors.black,
                          size: MediaQuery.of(context).size.height * 0.05
                      )
                  ),
                ],
              ),
          ),
          body: TabBarView(
            children: [
              Home(), Option(), MyFridge(),
            ],
          ),
          ),
        );
  }
}

import 'package:capstone_design_2022_spring/myFridge/MyFridge.dart';
import 'package:flutter/material.dart';
import 'package:capstone_design_2022_spring/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class recipePage extends StatefulWidget {

  final recipeNum;

  const recipePage({Key? key, @required this.recipeNum}) : super(key: key);

  @override
  _recipePageState createState() => _recipePageState();
}

class _recipePageState extends State<recipePage> {

  @override
  void initState() {
    super.initState();
    _loadMyFridge();
    _loadMyRecipe();
  }
  
  _loadMyFridge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myFridge = (prefs.getStringList('myFridge')) ?? [];
    });
  }
  
  _setMyFridge(List<String> input) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String> temp = (prefs.getStringList('myFridge')) ?? [];
      input = temp + input;
      prefs.setStringList('myFridge', input);
      ingredients.clear();
    });
  }

  _loadMyRecipe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myRecipe = (prefs.getStringList('myRecipe')) ?? [];
    });
  }

  _setMyRecipe(List<String> input) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String> temp = (prefs.getStringList('myRecipe')) ?? [];
      input = temp + input;
      prefs.setStringList('myRecipe', input);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery
            .of(context)
            .size
            .height * 0.15,
        title: Text('레시피 상세 정보', style: TextStyle(fontSize: 25.0)),
        elevation: 0.0,
        centerTitle: true,
        flexibleSpace: Container(
            decoration: myGradient
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: Text(recipeData[widget.recipeNum]['RCP_NM'],
                style: TextStyle(fontSize: 25),)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                    '${recipeData[widget.recipeNum]['ATT_FILE_NO_MAIN']}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(recipeData[widget.recipeNum]['RCP_PARTS_DTLS'], style: TextStyle(fontSize: 20),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('조리 과정', style: TextStyle(fontSize: 25),),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  String _index = (index + 1).toString();
                  _index = 'MANUAL0' + _index;
                  print('${recipeData[widget.recipeNum][_index]}');
                  return (!isEmpty(index)) ? Container(
                      child: Text('${recipeData[widget
                          .recipeNum][_index]}', style: TextStyle(
                          fontSize: 20),)
                  ) : SizedBox();
                },
                separatorBuilder: (BuildContext context,
                    int index) => const Divider(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.7,
                  height: 50,
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
                      onPressed: () {
                        _setMyFridge(ingredients);
                        _loadMyFridge();
                        _setMyRecipe([widget.recipeNum.toString()]);
                        _loadMyRecipe();

                        resultRecipe.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text('마이 냉장고에 레시피 저장')
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isEmpty(int index) {
    if (recipeData[widget.recipeNum]['MANUAL0+${index}'] == '') {
      print("$index is not empty");
      return true;
    }
    else {
      return false;
    }
  }
}
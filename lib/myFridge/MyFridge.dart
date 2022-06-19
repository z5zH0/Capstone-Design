import 'package:flutter/material.dart';
import '../resources.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fridgeChips.dart';
import 'package:capstone_design_2022_spring/home/recipePage.dart';

class MyFridge extends StatefulWidget {
  const MyFridge({Key? key}) : super(key: key);

  @override
  _MyFridgeState createState() => _MyFridgeState();
}

class _MyFridgeState extends State<MyFridge> {

  _deleteMyFridge() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('myFridge');
      myFridge = [];
    });
  }

  _deleteMyRecipe() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('myRecipe');
      myRecipe = [];
    });
  }

  @override
  Widget build(BuildContext context) {

    var delRep = myFridge.toSet();
    myFridge = delRep.toList();
    delRep = myRecipe.toSet();
    myRecipe = delRep.toList();
    print(myFridge);
    print(myRecipe);

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('최근 사용한 재료', style: TextStyle(fontSize: 25)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: myFridge.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.5,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3
                  ),
                  itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: fridgeChips(myFridge[index], context),
                  );
                }
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('내가 찜한 레시피', style: TextStyle(fontSize: 25)),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: myRecipe.length,
              itemBuilder: (BuildContext context, int index) {
                var recipeNum = int.parse(myRecipe[index]);
                print(recipeData[recipeNum]['RCP_NM']);
                String imageUrl = recipeData[recipeNum]['ATT_FILE_NO_MAIN'];
                return InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return recipePage(recipeNum: recipeNum);
                      }),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      height: 100,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                            child: Container(
                                height: 100,
                                width: 100,
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  child: Image.network('$imageUrl', fit: BoxFit.fill),
                                )),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text('${recipeData[recipeNum]['RCP_NM']}',
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    maxLines: 2),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.68,
                                child: Text('${recipeData[recipeNum]['RCP_PARTS_DTLS']}',
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: 10
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context,
                  int index) => const Divider(),
            ),
          ),
        ],
      ),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          light, dark
                        ]
                    )
                ),
                child: FloatingActionButton(
                  elevation: 0,
                  child: Text('재료\n초기화', style: TextStyle(fontSize: 10), textAlign: TextAlign.center),
                  backgroundColor: Colors.transparent,
                  onPressed: _deleteMyFridge,
                  heroTag: null,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          light, dark
                        ]
                    )
                ),
                child: FloatingActionButton(
                  elevation: 0,
                  child: Text('레시피\n초기화', style: TextStyle(fontSize: 10), textAlign: TextAlign.center),
                  backgroundColor: Colors.transparent,
                  onPressed: _deleteMyRecipe,
                  heroTag: null,
                ),
              )
            ]
        )

    );
  }
}
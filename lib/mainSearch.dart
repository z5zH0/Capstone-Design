import 'package:flutter/material.dart';
import 'resources.dart';
import 'home/recipePage.dart';

class mainSearch extends StatefulWidget {

  final ingName;

  const mainSearch({Key? key, @required this.ingName}) : super(key: key);

  @override
  _mainSearchState createState() => _mainSearchState();
}

class _mainSearchState extends State<mainSearch> {

  List temp = [];

  @override
  Widget build(BuildContext context) {

    getRecipes(widget.ingName);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery
            .of(context)
            .size
            .height * 0.15,
        title: Text('${widget.ingName} 포함 레시피 검색', style: TextStyle(fontSize: 25.0)),
        elevation: 0.0,
        centerTitle: true,
        flexibleSpace: Container(
            decoration: myGradient
        ),
      ),
      body: SafeArea(
          child: Expanded(
            child: ListView.separated(
              itemCount: temp.length,
              itemBuilder: (BuildContext context, int index){
                int recipeNum = temp[index];
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
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            ),
          )
      ),
    );
  }

  void getRecipes(String ing) {
    for (int i = 0; i < recipeData.length; i++){
      if(recipeData[i]['RCP_PARTS_DTLS'].contains(ing)){
        temp.add(i);
      }
    }
  }
}

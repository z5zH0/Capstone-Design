import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:capstone_design_2022_spring/resources.dart';
import 'recipePage.dart';
import 'package:capstone_design_2022_spring/userOptions.dart';

class recipeSearch extends StatefulWidget {
  const recipeSearch({Key? key}) : super(key: key);

  @override
  _recipeSearchState createState() => _recipeSearchState();
}

class _recipeSearchState extends State<recipeSearch> {

  List highMatch = [];
  List restThings = [];

  @override
  Widget build(BuildContext context) {

    getRecipes();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery
            .of(context)
            .size
            .height * 0.15,
        title: Text('추천 레시피', style: TextStyle(fontSize: 25.0)),
        elevation: 0.0,
        centerTitle: true,
        flexibleSpace: Container(
            decoration: myGradient
        ),
      ),
      body: SafeArea(
        child: Expanded(
          child: ListView.separated(
              itemCount: resultRecipe.length,
              itemBuilder: (BuildContext context, int index){
                int recipeNum = resultRecipe[index];
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

  void getRecipes() {
    var count = 0;
    for (int i = 0; i < recipeData.length; i++){
      for (int j = 0; j < ingredients.length; j++){
        if(recipeData[i]['RCP_PARTS_DTLS'].contains(ingredients[j])){
          count += 1;
          if(count == ingredients.length){ //추출된 재료 모두 탐색이 끝났을 때 + 추출된 재료가 모두 포함되어 있을 때
            highMatch.add(i);
          } else if (count == ingredients.length-1){
            restThings.add(i);
          }
        }
      }
      count = 0;
    }

    resultRecipe += highMatch;
    filter();
    if(resultRecipe.length >= 10){
      resultRecipe.shuffle();
      resultRecipe = resultRecipe.sublist(0,10);
      //print(resultRecipe);
    }
    if(resultRecipe.length < 10){
      resultRecipe = resultRecipe+restThings;
      filter();
      resultRecipe.shuffle();
      if(resultRecipe.length > 10){
        resultRecipe = resultRecipe.sublist(0,10);
        //print(resultRecipe);
      }
    }
  }

  void filter(){
    List temp = [];
    print('필터링 시작');
    if(likeOptions[0] == true){
      for (var i in resultRecipe){
        if(!recipeData[i]['RCP_PARTS_DTLS'].contains('고기')&&
            !recipeData[i]['RCP_PARTS_DTLS'].contains('닭')&&
            !recipeData[i]['RCP_PARTS_DTLS'].contains('돼지')&&
            !recipeData[i]['RCP_PARTS_DTLS'].contains('갈비')&&
            !recipeData[i]['RCP_PARTS_DTLS'].contains('오리')&&
            !recipeData[i]['RCP_PARTS_DTLS'].contains('베이컨')&&
            !recipeData[i]['RCP_PARTS_DTLS'].contains('햄'))
        {
          temp.add(i);
        }
      }
      resultRecipe = temp;
      temp = [];
      print('첫번째 필터');
      print(resultRecipe);
    }

    if(hateOptions[0] == true){
      for (var i in resultRecipe){
        if(!recipeData[i]['RCP_PARTS_DTLS'].contains('우유'))
        {
          temp.add(i);
        }
      }
      resultRecipe = temp;
      temp = [];
      print('두번째 필터');
      print(resultRecipe);
    }

    if(hateOptions[1] == true){
      for (var i in resultRecipe){
        if(!recipeData[i]['RCP_PARTS_DTLS'].contains('새우'))
        {
          temp.add(i);
        }
      }
      resultRecipe = temp;
      temp = [];
      print('세번째 필터');
      print(resultRecipe);
    }


  }
}

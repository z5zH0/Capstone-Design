import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources.dart';
import 'Chips.dart';

class Option extends StatelessWidget {
  const Option({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text('내 취향 설정하기', style: TextStyle(fontSize: 25.0),),
        elevation: 0.0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: myGradient
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8.0, top: 2.0),
                  child: ImageIcon(
                      AssetImage(
                          'images/check_rounded.png'),
                    color: Colors.green,
                  ),
                ),
                Text('이런 레시피/재료가 좋아요!', style: TextStyle(fontSize: 20)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Wrap(
                spacing: 6,
                alignment: WrapAlignment.start,
                children: [
                  Chips(chipName: '비건', isChecked: false, isLike: true, index: 0),
                  Chips(chipName: '건강식', isChecked: false, isLike: true, index: 1),
                  Chips(chipName: '다이어트식', isChecked: false, isLike: true, index: 2),
                  Chips(chipName: '육류', isChecked: false, isLike: true, index: 3),
                  Chips(chipName: '어류', isChecked: false, isLike: true, index: 4),
                ],
              ),
            ),
            SizedBox(height: 100),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8.0, top: 2.0),
                  child: ImageIcon(
                      AssetImage('images/x_rounded.png'),
                    color: Colors.red,
                  ),
                ),
                Text('이런 레시피/재료는 피하고 싶어요!', style: TextStyle(fontSize: 20)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Chips(chipName: '우유', isChecked: false, isLike: false, index: 0),
                  Chips(chipName: '새우', isChecked: false, isLike: false, index: 1),
                  Chips(chipName: '고칼로리', isChecked: false, isLike: false, index: 2),
                  Chips(chipName: '어패류', isChecked: false, isLike: false, index: 3),
                  Chips(chipName: '생선', isChecked: false, isLike: false, index: 4),
                  Chips(chipName: '매운 맛', isChecked: false, isLike: false, index: 5),
                  Chips(chipName: '오븐 필요', isChecked: false, isLike: false, index: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
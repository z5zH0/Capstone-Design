import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TextField(
          showCursor: false,
          decoration: InputDecoration(
              hintText: '메뉴, 재료로 레시피 검색하기',
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.search, color: Colors.white,),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none)
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.2)
          )
      ),
    );
  }
}

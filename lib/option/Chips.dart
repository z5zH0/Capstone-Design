import 'package:capstone_design_2022_spring/userOptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capstone_design_2022_spring/resources.dart';

class Chips extends StatefulWidget {

  Chips({Key? key,
    required this.chipName,
    required this.isChecked,
    required this.isLike,
    required this.index})
      : super(key: key);

  final String chipName;
  bool isChecked;
  final bool isLike;
  final int index;

  @override
  _ChipsState createState() => _ChipsState();
}

class _ChipsState extends State<Chips> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: widget.isChecked ? BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    regular, dark
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ) : BoxDecoration(
                color: Color(0xFFC4C4C4)
              )
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.all(16.0),
              primary: Colors.white,
              textStyle: const TextStyle(fontSize: 20, letterSpacing: -1),
            ),
            onPressed: () {
              setState(() {
                widget.isChecked = !widget.isChecked;
                if(widget.isLike){
                  likeOptions[widget.index] = !likeOptions[widget.index];
                }
                else{
                  hateOptions[widget.index] = !hateOptions[widget.index];
                }
              });
            },
            child: Text('${widget.chipName}'),
          ),
        ],
      ),
    );
  }
}
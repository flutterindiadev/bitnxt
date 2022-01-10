import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({Key? key,
    required this.text
  }) : super(key: key);
  String text;


  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        width: 170,
        decoration: const BoxDecoration(
          // color: Colors.black26,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.green,
                Colors.lightGreenAccent,
                Colors.lightGreenAccent,
              ]
          ),

        ),
        child:Center(child:
        Text(text, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),))
    );
  }
}
import 'package:flutter/material.dart';

class Paires extends StatelessWidget {
  String keys;
  String values;
  Paires({Key? key, required this.keys, required this.values}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(keys,style:const TextStyle(color: Colors.black54,fontWeight: FontWeight.w600),),
        Text(values,style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
      ],
    );
  }
}

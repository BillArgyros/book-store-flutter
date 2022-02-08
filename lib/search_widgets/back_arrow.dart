import 'package:flutter/material.dart';

Widget getBackArrow(context){
  return Padding(
    padding: const EdgeInsets.only(top:10.0,left: 10),
    child: Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
    ),
  );
}
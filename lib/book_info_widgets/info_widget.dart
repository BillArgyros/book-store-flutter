import 'package:flutter/material.dart';

Widget getMoreInfo(double screenWidth, double screenHeight,book) {
  return  Column(
    children: [
      const Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'More about this book',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15),
            )),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              book.description,
              style: const TextStyle(fontSize: 15),
            )),
      ),
    ],
  );
}
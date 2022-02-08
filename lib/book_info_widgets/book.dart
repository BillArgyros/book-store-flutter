import 'package:flutter/material.dart';

Widget getBook(context, screenWidth, screenHeight, book) {
  return Container(
    decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 1, color: Colors.black)),
        boxShadow: [
          BoxShadow(
              color: Colors.black,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1))
        ]),
    width: screenWidth * 0.35,
    height: screenHeight * 0.25,
    child: Image(
      fit: BoxFit.fill,
      image: NetworkImage(book.image),
    ),
  );
}
import 'package:flutter/material.dart';

getAppBar(context){
  return AppBar(
    title: const Padding(
      padding: EdgeInsets.only(right: 60.0),
      child: Center(
          child: Text(
            'My Cart',
            style: TextStyle(color: Colors.black),
          )),
    ),
    elevation: 10,
    backgroundColor: Colors.blueAccent,
    bottom: PreferredSize(
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: Colors.black
                )
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(0.0)),
    leading: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
    ),
  );
}
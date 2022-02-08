import 'package:flutter/material.dart';

getAppBar(context){
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
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
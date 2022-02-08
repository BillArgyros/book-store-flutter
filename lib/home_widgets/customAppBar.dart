import 'package:e_shop_test/home_widgets/searchButton.dart';
import 'package:flutter/material.dart';




Widget getCustomAppBar(context,screenWidth,screenHeight,scaffoldKey,bookList){
  return Container(
    width: screenWidth*1,
    decoration: const BoxDecoration(
        color: Colors.blueAccent,
        border: Border(
            top: BorderSide(
                width: 1,
                color: Colors.black
            )
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1)
          )
        ]
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: (){
                scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu_rounded,color: Colors.black,),
              label: const Text('')
          ),
          Container(
              child: searchButton(context,screenWidth,screenHeight,bookList)
          ),
        ],
      ),
    ),
  );
}



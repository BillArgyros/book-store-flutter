import 'package:e_shop_test/screens/search_screen.dart';
import 'package:flutter/material.dart';


//this widget represents a search function,but it just redirects to a new screen

Widget searchButton(context,screenWidth,screenHeight,bookList){
  return Container(
    padding: const EdgeInsets.only(right: 10),
    child: TextButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen(bookList: bookList,)),
        );
      },
      icon: const Icon(Icons.search_rounded,color: Colors.black,),
      label:const Text('Search Books',style: TextStyle(color: Colors.black),),
    ),
  );

}
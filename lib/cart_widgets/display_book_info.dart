import 'package:flutter/material.dart';

displayBookInfo(screenWidth,index,bookList){
  return Padding(
    padding: const EdgeInsets.only(top: 5.0),
    child: Container(
      width: screenWidth*0.65,
      child: ListTile(
        leading:Image(
          fit: BoxFit.fill,
          image: NetworkImage(bookList[index].image),
        ),
        title: Text(bookList[index].name,style: const TextStyle(fontSize: 12),),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('€'+bookList[index].price,
          ),
        ),
      ),
    ),
  );
}
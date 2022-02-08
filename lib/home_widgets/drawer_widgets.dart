import 'package:e_shop_test/models/book_model.dart';
import 'package:e_shop_test/screens/book_marks_screen.dart';
import 'package:e_shop_test/screens/category_screen.dart';
import 'package:flutter/material.dart';


Widget drawerWidget(context, List<BookModel> bookList){
  return  ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0,bottom: 20),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              border: Border(
                top: BorderSide(
                    color: Colors.black,
                    width: 1
                ),
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1
                ),
              )
            ),
            child: const Center(child: Padding(
              padding: EdgeInsets.only(top: 8.0 , bottom: 8),
              child: Text('Categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            )),
          ),
        ),
        category(context,'Fiction',bookList),
        category(context,'Romance',bookList),
        category(context,'Health',bookList),
        category(context,'Fantasy',bookList),
      ],
    );
  }

  Widget category(context,categoryTitle,bookList){
    return  Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: TextButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryScreen(categoryTitle: categoryTitle, bookList: bookList,)),
            );
          },
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(categoryTitle,style: const TextStyle(color: Colors.black,fontSize: 17),
                ),
                const Icon(Icons.chevron_right,size: 30,color: Colors.black,),
              ]
          )
      ),
    );

  }
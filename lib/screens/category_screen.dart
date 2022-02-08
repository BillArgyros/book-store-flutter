import 'package:e_shop_test/models/book_model.dart';
import 'package:e_shop_test/screens/book_info_screen.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  List<BookModel> bookList=[];
  String categoryTitle='';
  CategoryScreen({required this.bookList,required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(right: 60.0),
            child: Center(child: Text(categoryTitle,style: const TextStyle(color: Colors.black),)),
          ),
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(35),
          child: ListView(
            children: [
              Wrap(
                children:
                  bookList.map((book) =>
                      getBook(context,screenWidth, screenHeight,book)
                  ).toList()
              )
            ]
          ),
        ),
      ),
    );
  }

  Widget getBook(context,screenWidth, screenHeight,book) {
    if (book.category.contains(categoryTitle.toLowerCase())) {
      return TextButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  BookInfoScreen(book: book,bookList: bookList,)),
          );
        },
        child: Column(
          children: [
            Container(
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
            ),
            Container(
              padding: EdgeInsetsDirectional.only(top: 5),
              width: screenWidth*0.3,
              height: screenHeight*0.035,
              child: Text(book.name,style: const TextStyle(color: Colors.black,fontSize: 8),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                child: Text('€'+book.price,style: const TextStyle(color: Colors.black,fontSize: 10),),
              ),
            ),
          ],
        ),
      );
    }else{
      return const SizedBox();
    }
  }

}

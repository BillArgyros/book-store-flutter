import 'package:e_shop_test/screens/category_screen.dart';
import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../screens/book_info_screen.dart';

class BookList extends StatefulWidget {

  List<BookModel> bookList=[];

  BookList({required this.bookList});


  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
            return Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: SizedBox(
                width: screenWidth * 1,
                height: screenHeight * 0.8,
                child: getCategories(screenWidth,screenHeight,widget.bookList),
              ),
            );
  }




  //create the different categories
  getCategories(screenWidth,screenHeight, List<BookModel> bookList) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: ListView(
        children: [
          createCategory(screenWidth,screenHeight,'Fiction',bookList),
          createCategory(screenWidth,screenHeight,'Romance',bookList),
          createCategory(screenWidth,screenHeight,'Health',bookList),
          createCategory(screenWidth,screenHeight,'Fantasy',bookList),
        ],
      ),
    );
  }


  //for every category go through the book list
 Widget createCategory(screenWidth,screenHeight,categoryTitle,List<BookModel> bookList){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //this is where the name of the category is being made,when pressed it goes inside the category screen
          getSeeMoreButton(categoryTitle,bookList),
          Container(
            width: screenWidth*1,
            height: screenHeight*0.3,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:
                bookList.map((book) =>
                    getBook(context ,screenWidth, screenHeight, book, categoryTitle)
                ).toList(),
            ),
          )
        ],
      ),
    );
  }


  //display the books that have a category property the same as the name of the category,when a book is pressed the screen changes
  Widget getBook(context, screenWidth, screenHeight, book , categoryTitle) {
    if (book.category.contains(categoryTitle.toLowerCase())) {
      return TextButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  BookInfoScreen(book: book,bookList: widget.bookList,)),
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
              width: screenWidth * 0.3,
              height: screenHeight * 0.2,
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(book.image),
              ),
            ),
            Container(
              padding: const EdgeInsetsDirectional.only(top: 5),
              width: screenWidth*0.3,
              height: screenHeight*0.04,
              child: Text(book.name,style: const TextStyle(color: Colors.black,fontSize: 8),),
            ),
            Container(
              child: Text('€' + book.price,style: const TextStyle(color: Colors.black,fontSize: 10),),
            ),
          ],
        ),
      );
    }else{
      return Container();
    }
  }


  Widget getSeeMoreButton(categoryTitle,bookList){
    return TextButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  CategoryScreen(bookList: bookList, categoryTitle: categoryTitle)),
        );
      },
      child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(categoryTitle,style: const TextStyle(color: Colors.black,fontSize: 17),),
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Text('See More',style: TextStyle(color: Colors.black,fontSize: 17),),
        )
      ],
    ),
    );
  }

}

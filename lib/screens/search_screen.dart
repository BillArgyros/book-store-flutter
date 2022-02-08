import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_test/loading.dart';
import 'package:e_shop_test/models/book_model.dart';
import 'package:e_shop_test/search_widgets/back_arrow.dart';
import 'package:e_shop_test/search_widgets/manage_data.dart';
import 'package:flutter/material.dart';
import 'book_info_screen.dart';

class SearchScreen extends StatefulWidget {
  List<BookModel> bookList;


  SearchScreen({required this.bookList});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String searchItem='';
  bool searching=false;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> books =
    FirebaseFirestore.instance.collection('books').snapshots();
    List<BookModel> bookList = [];
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
          return StreamBuilder<QuerySnapshot?>(
              stream: books,
            builder: (context, snapshot) {
                if(snapshot.hasData) {
                  final data = snapshot.data;
                  bookList = createBookList(data);
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: Scaffold(
                      resizeToAvoidBottomInset: false,
                      body: Stack(
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                Container(
                                  width: screenWidth * 1,
                                  height: screenHeight * 0.08,
                                  decoration: const BoxDecoration(
                                    color: Colors.blueAccent,
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Colors.black
                                        )
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      getBackArrow(context),
                                      _searchBar(screenWidth, screenHeight),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 35,right: 35,left: 35),
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }else{
                  return  Loading();
                }
            }
          );
  }

  Widget _searchBar(double screenWidth, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.only(top:10.0,left: 10),
      child: Container(
        width: screenWidth*0.7,
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          child:  Focus(
            child:  TextField(
              autofocus: true,
              style: const TextStyle(fontSize: 17,),
              onChanged: (text) => searchItem=text,
              cursorColor: Colors.transparent,
              decoration: const InputDecoration(
                hintText: 'Search Books',
                hintStyle: TextStyle(fontSize: 15,color: Colors.black),
                focusColor: Colors.transparent,
                fillColor: Colors.transparent,
                hoverColor: Colors.transparent,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
            onFocusChange: (hasFocus){
              if(hasFocus){
              }else{
                setState(() {
                  if(searchItem==''){
                    searching=false;
                  }else{
                    searching=true;
                  }
                });
              }
            },
          ),
        ),
      ),
    );
  }



  //if the searching words match part of the title of a book display that book
  Widget getBook(context,screenWidth, screenHeight,book) {
     searchItem = searchItem.trim();
     String name = book.name.trim();
      if (searchItem.isNotEmpty) {
        if (name.toLowerCase().contains(searchItem.toLowerCase())) {
          return TextButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookInfoScreen(book: book,bookList: widget.bookList,)),
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
      }else{
        return SizedBox();
      }
  }


}

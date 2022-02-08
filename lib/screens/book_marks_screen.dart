import 'package:e_shop_test/loading.dart';
import 'package:e_shop_test/models/book_model.dart';
import 'package:e_shop_test/models/user_model.dart';
import 'package:e_shop_test/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_info_screen.dart';

class BookMarksScreen extends StatefulWidget {
  List<BookModel> bookList = [];

  BookMarksScreen({required this.bookList});

  @override
  _BookMarksScreenState createState() => _BookMarksScreenState();
}

class _BookMarksScreenState extends State<BookMarksScreen> {

  List<dynamic> bookMark= [];

  @override
  Widget build(BuildContext context) {
    // get the information regarding the current logged user
    final user = Provider.of<UserModel?>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user?.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data!;
          bookMark = [];
          bookMark.addAll(userData.bookMark);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: getAppBar(),
              //if the user doesn't have any bookmarks, print a message, otherwise display the bookmarked books
              body: bookMark.isNotEmpty? Padding(
                padding: const EdgeInsets.all(35),
                child: ListView(
                   scrollDirection: Axis.vertical,
                    children: [
                      Wrap(
                        children: widget.bookList
                            .map((book) =>
                            getBook(context, screenWidth, screenHeight, book))
                            .toList(),
                      )
                    ]),
              ):
                  Center(child: Text('Your bookmarks are empty',style: TextStyle(fontSize: 18 ,color: Colors.black.withOpacity(0.5)),)),
            ),
          );
        }else{
          return Loading();
        }
      }
    );
  }

  Widget getBook(context, screenWidth, screenHeight, book) {
    if (bookMark.contains(book.name)) {
      return TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookInfoScreen(book: book, bookList: widget.bookList,)),
          );
        },
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(top: BorderSide(width: 1, color: Colors.black)),
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
              padding: const EdgeInsetsDirectional.only(top: 5),
              width: screenWidth * 0.3,
              height: screenHeight * 0.035,
              child: Text(
                book.name,
                style: const TextStyle(color: Colors.black, fontSize: 8),
              ),
            ),
            Text(
              '€' + book.price,
              style: const TextStyle(color: Colors.black, fontSize: 10),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }


  getAppBar(){
   return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(right: 60.0),
        child: Center(
            child: Text(
              'My Bookmarks',
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

}

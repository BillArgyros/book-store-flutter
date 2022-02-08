import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_test/home_widgets/book_list.dart';
import 'package:e_shop_test/home_widgets/customAppBar.dart';
import 'package:e_shop_test/home_widgets/drawer_widgets.dart';
import 'package:e_shop_test/home_widgets/manage_data.dart';
import 'package:e_shop_test/home_widgets/nav_bar.dart';
import 'package:e_shop_test/loading.dart';
import 'package:e_shop_test/models/book_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //scaffold key responsible for creating a drawer inside a scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    //get firebase information regarding existing books
    final Stream<QuerySnapshot> books =
        FirebaseFirestore.instance.collection('books').snapshots();
    List<BookModel> bookList = [];
    return StreamBuilder<QuerySnapshot?>(
        stream: books,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            //properly format the book data in a list
            bookList = createBookList(data);
            return MaterialApp(
              initialRoute: '/',
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                key: _scaffoldKey,
                drawer: Drawer(
                  backgroundColor:const Color.fromRGBO(229, 229, 229, 1),
                  child: drawerWidget(context, bookList),
                ),
                resizeToAvoidBottomInset: false,
                body: Container(
                  color: const Color.fromRGBO(229, 229, 229 ,1),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          getCustomAppBar(
                              context, screenWidth, screenHeight, _scaffoldKey,bookList),
                          BookList(
                            bookList: bookList,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(229, 229, 229 ,1),
                              border: Border(
                                  top: BorderSide(width: 1, color: Colors.black)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    spreadRadius: 3,
                                    blurRadius: 1,
                                    offset: Offset(0, 3))
                              ]),
                          width: screenWidth * 1,
                          child: nav_bar(context,bookList),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return  Loading();
          }
        });
  }


  //create a custom bottom navigation bar
  Widget nav_bar(context,bookList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: profileButton(context),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: bookMarkButton(context,bookList),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: cartButton(context,bookList),
        ),
      ],
    );
  }

}

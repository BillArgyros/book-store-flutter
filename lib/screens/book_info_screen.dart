import 'package:e_shop_test/book_info_widgets/app_bar.dart';
import 'package:e_shop_test/book_info_widgets/book.dart';
import 'package:e_shop_test/book_info_widgets/info_widget.dart';
import 'package:e_shop_test/models/book_model.dart';
import 'package:e_shop_test/models/user_model.dart';
import 'package:e_shop_test/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_screen.dart';

class BookInfoScreen extends StatefulWidget {
  BookModel book;

  List<BookModel> bookList;

  BookInfoScreen({Key? key, required this.book,required this.bookList}) : super(key: key);

  @override
  State<BookInfoScreen> createState() => _BookInfoScreenState();
}

class _BookInfoScreenState extends State<BookInfoScreen> {
  bool cartIsPressed = false;
  bool bookMarkIsPressed = false;
  List<dynamic> bookMark = [];
  List<dynamic> cart = [];

  @override
  Widget build(BuildContext context) {
    // get the information regarding the current logged user
    final user = Provider.of<UserModel?>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;
            dataManager(userData);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                appBar: getAppBar(context),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Container(
                          height: screenHeight * 0.25,
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  color: Colors.black,
                                  child: getBook(context, screenWidth,
                                      screenHeight, widget.book),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      getBookInfo(screenWidth,screenHeight),
                                      getBookProperties(user,snapshot,userData,screenWidth,screenHeight),
                                      getBuyButton(user,userData,screenWidth,screenHeight),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                       getMoreInfo(screenWidth,screenHeight,widget.book),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }



  //display the book information, when a book is being added/removed firebase is being updated
  Widget getBookProperties(user,snapshot,userData,screenWidth,screenHeight){
    return Row(
      children: [
        TextButton.icon(
          onPressed: () async {
            setState(() {
              bookMarkIsPressed =
              !bookMarkIsPressed;
              if (bookMarkIsPressed) {
                bookMark.add(widget.book.name);
              } else {
                bookMark
                    .remove(widget.book.name);
              }
            });

            if (snapshot.hasData) {
              await DatabaseService(
                  uid: user?.uid)
                  .updateUserData(
                  userData.name,
                  userData.phone,
                  userData.email,
                  userData.password,
                  userData.cart,
                  bookMark);
            }
          },
          icon: bookMarkIsPressed
              ? const Icon(
              Icons.bookmark_rounded,
              color: Colors.red)
              : const Icon(
              Icons
                  .bookmark_outline_rounded,
              color: Colors.black),
          label: const Text(
            '',
            style: TextStyle(
                color: Colors.black,
                fontSize: 15),
          ),
        ),
        TextButton.icon(
          onPressed: ()  async {
            setState(() {
              cartIsPressed = !cartIsPressed;
              if (cartIsPressed) {
                cart.add(widget.book.name);
              } else {
                cart
                    .remove(widget.book.name);
              }
            });
            if (snapshot.hasData) {
              await DatabaseService(
                  uid: user?.uid)
                  .updateUserData(
                  userData.name,
                  userData.phone,
                  userData.email,
                  userData.password,
                  cart,
                  userData. bookMark);
            }
          },
          icon: cartIsPressed
              ? const Icon(
              Icons.shopping_cart_rounded,
              color: Colors.green)
              : const Icon(
              Icons
                  .shopping_cart_outlined,
              color: Colors.black),
          label: const Text(
            '',
            style: TextStyle(
                color: Colors.black,
                fontSize: 15),
          ),
        ),
      ],
    );
  }

  //this function checks if the user has already added the book in his favourites and his cart
  void dataManager(userData) {
    bookMark = [];
    cart=[];
    cart.addAll(userData.cart);
    bookMark.addAll(userData.bookMark);
    if (bookMark.contains(widget.book.name)) {
      bookMarkIsPressed = true;
    }else{
      bookMarkIsPressed=false;
    }
    if (cart.contains(widget.book.name)) {
      cartIsPressed = true;
    }else{
      cartIsPressed=false;
    }
  }


//when the button is pressed, the book is being added to the users cart information and the database is being updated, the app opens the cart screen
 Widget getBuyButton(user,userData,screenWidth,screenHeight){
  return  Container(
      height: screenHeight * 0.05,
      width: screenWidth * 0.4,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius:
          BorderRadius.circular(32),
          border: Border.all(
            color: Colors.black,
            width: 1,
          )),
      child: TextButton(
        onPressed: () async {
          if(cartIsPressed==false){
            cart.add(widget.book.name);
            await DatabaseService(
                uid: user?.uid)
                .updateUserData(
                userData.name,
                userData.phone,
                userData.email,
                userData.password,
                cart,
                userData.bookMark);
          }else{
            await DatabaseService(
                uid: user?.uid)
                .updateUserData(
                userData.name,
                userData.phone,
                userData.email,
                userData.password,
                cart,
                userData.bookMark);
          }
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CartScreen(
                  bookList: widget.bookList,
                )),
          );
        },
        child: Text(
          'Buy €' + widget.book.price,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 15),
        ),
      ),
    );
  }

 Widget getBookInfo(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.4,
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.book.name,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight:
                    FontWeight.bold),
              )),
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.book.author,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight:
                    FontWeight.w400),
              )),
        ],
      ),
    );
  }

}

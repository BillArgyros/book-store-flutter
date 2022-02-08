import 'package:e_shop_test/cart_widgets/app_bar.dart';
import 'package:e_shop_test/cart_widgets/display_book_info.dart';
import 'package:e_shop_test/cart_widgets/price_calculator.dart';
import 'package:e_shop_test/loading.dart';
import 'package:e_shop_test/models/book_model.dart';
import 'package:e_shop_test/models/user_model.dart';
import 'package:e_shop_test/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_info_screen.dart';

class CartScreen extends StatefulWidget {

  List<BookModel> bookList = [];

  CartScreen({required this.bookList});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  List<dynamic> cart= [];
  String totalPrice='0';


  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    // get the information regarding the current logged user
    final user = Provider.of<UserModel?>(context);
    return StreamBuilder<UserData>(
    stream: DatabaseService(uid: user?.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data!;
          cart = [];
          cart.addAll(userData.cart);
          //calculate the total price of all the items in the cart
          totalPrice = calcTotalPrice(widget.bookList,cart);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: getAppBar(context),
              //if the users cart is empty print message, otherwise display the information regarding the users cart
              body: cart.isNotEmpty? Stack(
                children: [
                  getCartItems(screenHeight,screenWidth,context,user,userData,widget.bookList),
                  getCashOut(screenHeight,user,userData),
                ],
              ) :
              Center(child: Text('Your cart is empty',style: TextStyle(fontSize: 18 ,color: Colors.black.withOpacity(0.5)),)),

            ),
          );
        }else{
          return Loading();
        }
      }
    );
  }


// this method renders and manages the ability to change the quantity of any items in the cart as well as to delete it
  displayCountInfo(screenWidth,index){
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Container(
            width: screenWidth*0.12,
            child: TextButton.icon(
                onPressed: (){
                  setState(() {
                    if(widget.bookList[index].count>1){
                      widget.bookList[index].count--;
                    }
                  });
                },
                icon: const Icon(Icons.remove,size: 15,color: Colors.black),
                label: const Text('')
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Text(widget.bookList[index].count.toString()),
        ),

        Container(
          width: screenWidth*0.12,
          child: TextButton.icon(
              onPressed: (){
                setState(() {
                  widget.bookList[index].count++;
                });
              },
              icon: const Icon(Icons.add,size: 15,color: Colors.black,),
              label: const Text('')
          ),
        ),
      ],
    );
  }




  cartManager(double screenWidth, double screenHeight, int index, user, UserData userData) {
    return Column(
      children: [
        displayCountInfo(screenWidth,index),
        TextButton.icon(
            onPressed: () async {
              setState(() {
                cart.remove(widget.bookList[index].name);
              });
              await DatabaseService(
                  uid: user?.uid)
                  .updateUserData(
                  userData.name,
                  userData.phone,
                  userData.email,
                  userData.password,
                  cart,
                  userData.bookMark);
            },
            icon: const Icon(Icons.cancel,color: Colors.red,),
            label: const Text('')
        ),
      ],
    );
  }

// display the total price of the cart and the button for completing the order, when its pressed clear the cart of the user and go to the home page
  getCashOut(screenHeight,user,userData){
    return  Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: 1,
                    color: Colors.black
                )
            )
        ),
        //color: Colors.red,
        height: screenHeight*0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:   [
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Total Price: €' + totalPrice.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    cart=[];
                  });
                  await DatabaseService(
                      uid: user?.uid)
                      .updateUserData(
                      userData.name,
                      userData.phone,
                      userData.email,
                      userData.password,
                      cart,
                      userData.bookMark);
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                },
                child: const Text('Check Out',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 15),),
              ),
            ),

          ],
        ),
      ),
    );
  }


  //check the book list and choose the ones that are in the cart and display their information
  getCartItems( screenHeight,  screenWidth,  context , user, userData,bookList) {
    return Container(
      height: screenHeight*0.84,
      child: Padding(
        padding: const EdgeInsets.only(top: 35),
        child:  ListView.builder(
          itemCount: bookList.length,
          itemBuilder: (context,index){
            if (cart.contains(bookList[index].name)) {
              return  Card(
                elevation: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    displayBookInfo(screenWidth,index,bookList),
                    Container(
                      width: screenWidth*0.3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 0),
                        child: cartManager(screenWidth,screenHeight,index,user,userData),
                      ),
                    ),
                  ],
                ),
              );
            }else{
              return SizedBox();
            }
          },
        ),

      ),
    );
  }

}

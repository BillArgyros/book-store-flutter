import 'package:e_shop_test/screens/book_marks_screen.dart';
import 'package:e_shop_test/screens/cart_screen.dart';
import 'package:e_shop_test/screens/profile_screen.dart';
import 'package:flutter/material.dart';

Widget cartButton(context,bookList) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, right: 0.0),
    child: TextButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CartScreen(
                bookList: bookList,
              )),
        );      },
      icon: const Icon(
        Icons.shopping_cart_rounded,
        size: 30,
        color: Colors.black,
      ),
      label: const Text(""),
    ),
  );
}

Widget profileButton(context) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, right: 0.0),
    child: TextButton.icon(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      },
      icon: const Icon(
        Icons.person_rounded,
        size: 30,
        color: Colors.black,
      ),
      label: const Text(""),
    ),
  );
}

Widget bookMarkButton(context, bookList) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, right: 0.0),
    child: TextButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookMarksScreen(
                      bookList: bookList,
                    )),
          );
        },
        icon: const Icon(Icons.bookmark_outline_rounded,
            color: Colors.black, size: 30),
        label: const Text('')),
  );
}

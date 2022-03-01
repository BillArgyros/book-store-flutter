import 'package:e_shop_test/models/book_model.dart';

class UserModel{
  final String uid;

  UserModel({ required this.uid});
}

class UserData{

  String uid;
  String name;
  String phone;
  String email;
  String password;
  List<dynamic> cart = [];
  List<dynamic> bookMark = [];


  UserData( {required this.phone, required this.email, required this.uid, required this.password,required this.name, required this.cart,required this.bookMark});

}
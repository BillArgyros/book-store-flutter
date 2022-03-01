import 'package:e_shop_test/models/user_model.dart';
import 'package:e_shop_test/screens/home_screen.dart';
import 'package:e_shop_test/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel?>(context);
    //check if there is a user logged in
    if(user==null){
      return  LoginScreen();
    }else{
      return  HomeScreen();
    }

  }
}

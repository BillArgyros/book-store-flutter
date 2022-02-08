import 'package:e_shop_test/loading.dart';
import 'package:e_shop_test/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../services/database.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final _formKeyName=GlobalKey<FormState>();
  final _formKeyPhone=GlobalKey<FormState>();
  final _formKeyEmail=GlobalKey<FormState>();
  final AuthServices _authServices= AuthServices();

   bool phoneIsToggled=false;
   bool nameIsToggled=false;
   bool emailIsToggled=false;
   String email='';
   String name='';
   String phone='';
   String emailInfo='';
   String nameInfo='';
   String phoneInfo='';
   List<dynamic> cart=[];
   List<dynamic> bookMark=[];


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data!;
         return MaterialApp(
           debugShowCheckedModeBanner: false,
           home: Scaffold(
             body: Stack(
               children: [
                 Container(
                   color: Color.fromRGBO(229, 229, 229 ,1),
                   width: screenWidth * 1,
                   height: screenHeight * 1,
                 ),
                 getButtons(screenWidth,screenHeight,userData,user),
                 Align(
                   alignment: Alignment.bottomCenter,
                   child: signOutButton(context,screenWidth,screenHeight),
                 )
               ],
             ),
           ),
         );
       }else{
         return  Center(child: Loading());
       }
      }
    );
  }

  _getName(double screenWidth, double screenHeight, UserData userData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0,left:20),
          child: Container(
            child:  Text(name==''?userData.name:name),
          ),
        ),
        TextButton.icon(
            onPressed: (){
          setState(() {
            nameIsToggled=!nameIsToggled;
          });
        },
        icon: Icon(Icons.edit_sharp), label: Text("")),
      ],
    );
  }

  _getPhone(double screenWidth, double screenHeight, UserData userData ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0.0,left:20),
          child: Container(
            child:  Text(phone==''?userData.phone:phone),
          ),
        ),
        TextButton.icon(
            onPressed: (){
          setState(() {
            phoneIsToggled=!phoneIsToggled;
          });
        },
            icon: Icon(Icons.edit_sharp), label: Text("")),
      ],
    );

  }

  _getEmail(double screenWidth, double screenHeight, UserData userData) {
    return Container(
      decoration: BoxDecoration(
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0,left:20),
            child: Container(
              child:  Text(email==''?userData.email:email),
            ),
          ),
          TextButton.icon(
              onPressed: (){
                setState(() {
                  emailIsToggled=!emailIsToggled;
                });
              },
              icon: Icon(Icons.edit_sharp), label: Text("")),
        ],
      ),
    );
  }


  Widget _textFieldName(BuildContext context, double screenWidth, double screenHeight,UserData userData){
    return Form(
      key: _formKeyName,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0,left:20),
            child: SizedBox(
              width: screenWidth * 0.75,
              height: screenHeight*0.09,
              child: TextFormField(
                initialValue: nameInfo==''? userData.name : nameInfo,
                validator: (text) => text!.isEmpty?'Please enter your name':null,
                onChanged: (text) => {name = text, nameInfo=name},
                decoration: const InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextButton.icon(
                onPressed: (){
                  setState(() {
                    if (_formKeyName.currentState!.validate()) {
                      nameIsToggled=!nameIsToggled;
                    }
                  });
                },
                icon: const Icon(Icons.done), label: const Text("")
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFieldPhone(BuildContext context, double screenWidth, double screenHeight, UserData userData){
    return Form(
      key: _formKeyPhone,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0,left:20),
            child: SizedBox(
              width: screenWidth * 0.75,
              height: screenHeight*0.09,
              child: TextFormField(
                initialValue: phoneInfo==''? userData.phone:phoneInfo,
                validator: (text) => text!.isEmpty?'Please enter a phone number':null,
                onChanged: (text) => {phone = text,phoneInfo=phone},
                decoration: const InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextButton.icon(
                onPressed: (){
                  setState(() {
                    if (_formKeyPhone.currentState!.validate()) {
                      phoneIsToggled=!phoneIsToggled;
                    }
                  });
                },
                icon: const Icon(Icons.done), label: const Text("")
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFieldEmail(BuildContext context, double screenWidth, double screenHeight, UserData userData){
    return Form(
      key: _formKeyEmail,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0,left:20),
            child: SizedBox(
              width: screenWidth * 0.75,
              height: screenHeight*0.09,
              child: TextFormField(
                initialValue: emailInfo==''?userData.email:emailInfo,
                validator: (text) => text!.isEmpty?'Please enter an email':null,
                onChanged: (text) => {email=text, emailInfo=email},
                decoration: const InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextButton.icon(
                onPressed: (){
                  setState(() {
                    if (_formKeyEmail.currentState!.validate()) {
                      emailIsToggled=!emailIsToggled;
                    }
                  });
                },
                icon: const Icon(Icons.done), label: Text("")
            ),
          ),
        ],
      ),
    );
  }

 Widget signOutButton(context,screenWidth,screenHeight){
   return Padding(
     padding: const EdgeInsets.only(bottom: 30.0),
     child: Container(
       width: screenWidth*0.25,
       height: screenHeight*0.05,

       decoration: BoxDecoration(
           color: Colors.blueAccent,
           borderRadius: BorderRadius.circular(32),
           boxShadow: const [
             BoxShadow(
                 blurRadius: 4,
                 offset: Offset(0,1)
             )
           ]
       ),
       child: TextButton(
         onPressed: (){
           _authServices.signOut();
           Navigator.pop(context);
         },
         child: FittedBox(child: const Text("Sign out",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
       ),
     ),
   );
 }


 Widget getButtons(screenWidth,screenHeight,userData,user){
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0,left: 20),
              child: Container(
                width: screenWidth*0.25,
                height: screenHeight*0.05,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 4,
                          offset: Offset(0,1)
                      )
                    ]
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Center(
                    child: TextButton(
                      child: FittedBox(child: const Text('Go Back',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: screenWidth*0.25,
                    height: screenHeight*0.05,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 4,
                              offset: Offset(0,1)
                          )
                        ]
                    ),
                    child: Center(
                      child: TextButton(
                        child: const FittedBox(child: Text('Save',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),
                        onPressed: () async{
                          await DatabaseService(uid: user?.uid).updateUserData(name==''?userData.name:name, phone==''?userData.phone:phone, email==''?userData.email:email, userData.password,userData.cart,userData.bookMark);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: screenWidth*1,
          height: screenHeight*0.2,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5.0,left: 5),
          child: Card(
            elevation: 10,
            child: Column(
              children: [
                nameIsToggled?   _textFieldName(context, screenWidth, screenHeight,userData): _getName(screenWidth, screenHeight,userData),
               // emailIsToggled?  _textFieldEmail(context, screenWidth, screenHeight,userData): _getEmail(screenWidth, screenHeight,userData),
                phoneIsToggled?  _textFieldPhone(context, screenWidth, screenHeight,userData): _getPhone(screenWidth, screenHeight,userData),
              ],
            ),
          ),
        ),
            ],
        );
 }


}

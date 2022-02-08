import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_test/models/book_model.dart';
import 'package:firebase_core/firebase_core.dart';
import '../models/user_model.dart';

class DatabaseService{


  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference userInfo = FirebaseFirestore.instance.collection('userInfo');
  final CollectionReference booksCollection=FirebaseFirestore.instance.collection('books');

  Future updateUserData(String name, String phone, String email, String password, List<dynamic> cart , List<dynamic> bookMark) async{
      return await userInfo.doc(uid).set({
        'name':name,
        'email':email,
        'phone':phone,
        'password':password,
        'cart': cart,
        'bookMark':bookMark
      });
    }


  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
   // print(snapshot.get('phone'));
    return UserData( phone: snapshot.get('phone'),email: snapshot.get('email'),password: snapshot.get('password'), uid: uid!, name: snapshot.get('name'), cart: snapshot.get('cart'), bookMark: snapshot.get('bookMark'));
  }



  Stream<UserData> get userData{
    return userInfo.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  List<BookModel> _booksListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return BookModel(name: doc.get('name'), price: doc.get('price'), image: doc.get('image'), category: doc.get('category'), author: doc.get('author') ,description: doc.get('description'));
    }
    ).toList();
  }

   Stream<List<BookModel>> get booksProvider{
    return booksCollection.snapshots().map(_booksListFromSnapshot);
   }


}

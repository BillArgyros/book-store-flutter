import 'package:e_shop_test/models/book_model.dart';

List<BookModel> createBookList(data) {
  List<BookModel> bookList = [];
  for (var element in data.docs) {
    BookModel bookModel = BookModel(
        name: element['name'],
        price: element['price'],
        image: element['image'],
        category: element['category'],
        author: element['author'],
        description: element['description']
    );
    bookList.add(bookModel);
  }
  return bookList;
}
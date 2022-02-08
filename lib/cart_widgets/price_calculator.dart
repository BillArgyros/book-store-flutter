String calcTotalPrice(bookList,cart) {
  double total=0;
  for(var element in cart){
    var index=bookList.indexWhere((item) => item.name==element);
    total=total+ bookList[index].count*double.parse(bookList[index].price);
  }
 return total.toStringAsFixed(2);

}
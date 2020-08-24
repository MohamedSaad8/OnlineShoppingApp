import 'package:flutter/cupertino.dart';
import 'package:onlineshoppingapp/Models/ProductModal.dart';

class CartProduct extends ChangeNotifier
{
  List<Product> products = [] ;
  addProduct(Product product)
  {
    products.add(product);
    notifyListeners();

  }

  removeProduct(Product product)
  {
    products.remove(product);
    notifyListeners();
  }
}
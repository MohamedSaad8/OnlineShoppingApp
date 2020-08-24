import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshoppingapp/constants.dart';
import 'package:onlineshoppingapp/screens/AdminScreens/OrdersScreen.dart';
import 'package:onlineshoppingapp/screens/AdminScreens/addProduct.dart';
import 'package:onlineshoppingapp/screens/AdminScreens/editProduct.dart';
import 'package:onlineshoppingapp/widgets/custom_text_filed.dart';

class AdminHome extends StatelessWidget {
  static String id = "AdminHome";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMAinColor,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                Navigator.pushNamed(context, AddProduct.id);
              },
              child: Text("Add Product"),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.pushNamed(context, EditProduct.id);
              },
              child: Text("Edit Product"),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.pushNamed(context, OrderScreen.id);
              },
              child: Text("View Orders"),
            ),

          ],
        ),
      )
    );
  }
}

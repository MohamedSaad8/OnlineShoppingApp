import 'package:flutter/material.dart';
import 'package:onlineshoppingapp/Models/ProductModal.dart';
import 'package:onlineshoppingapp/constants.dart';
import 'package:onlineshoppingapp/services/store.dart';
import 'package:onlineshoppingapp/widgets/custom_text_filed.dart';

class AddProduct extends StatelessWidget {
  static String id = "AddProduct";
  String name , description , price , category , location ;
  final _store = Store();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMAinColor,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextFiled(
              hint: "Product Name",
              fun: (value)
              {
                name =value ;
              },
            ),
            SizedBox(height: 10,),
            CustomTextFiled(
              hint: "Product Price",
              fun: (value)
              {
                price =value;
              },
            ),
            SizedBox(height: 10,),
            CustomTextFiled(
              hint: "Product Description",
              fun: (value)
              {
                description =value ;
              },
            ),
            SizedBox(height: 10,),
            CustomTextFiled(
              hint: "Product Category",
              fun: (value)
              {
                category =value ;
              },
            ),
            SizedBox(height: 10,),
            CustomTextFiled(
              hint: "Product Image Location",
              fun: (value)
              {
                location =value ;
              },
            ),
            SizedBox(height: 20,),
            RaisedButton(
              color: kSecondaryColor,
              onPressed: (){
                if(_globalKey.currentState.validate())
                  {
                    _globalKey.currentState.save();
                    _store.addProduct(Product(
                      productName: name,
                      productCategory: category,
                      productDescription: description,
                      productImageLocation: location,
                      productPrice: price,
                    ));
                  }

              },
              child: Text("ADD"),
            ),

          ],
        ),
      ),
    );
  }
}

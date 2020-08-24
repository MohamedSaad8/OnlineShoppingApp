import 'package:flutter/material.dart';
import 'package:onlineshoppingapp/Models/ProductModal.dart';
import 'package:onlineshoppingapp/services/store.dart';
import 'package:onlineshoppingapp/widgets/custom_text_filed.dart';
import '../../constants.dart';
// ignore: must_be_immutable
class ModifyProduct extends StatelessWidget {
  static String id = "ModifyProduct";
  String name , description , price , category , location ;
  final _store = Store();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments ;
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
                  _store.modifyProduct((
                    {
                      kProductName : name ,
                      kProductCategory :category ,
                      kProductDescription :description ,
                      kProductImageLocation : location ,
                      kProductPrice : price
                    }

                  ), product.productID);
                }

              },
              child: Text("Save changed"),
            ),

          ],
        ),
      ),
    );
  }
}

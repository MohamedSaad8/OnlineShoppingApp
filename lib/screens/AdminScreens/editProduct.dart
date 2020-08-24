import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshoppingapp/Models/ProductModal.dart';
import 'package:onlineshoppingapp/screens/AdminScreens/modifyproduct.dart';
import 'package:onlineshoppingapp/services/store.dart';
import 'package:onlineshoppingapp/widgets/customMenu.dart';

import '../../constants.dart';

class EditProduct extends StatelessWidget {
  static String id = "EditProduct";

  @override
  Widget build(BuildContext context) {
    final _store = Store();
    return Scaffold(
      body: StreamBuilder(
        stream: _store.loadProduct(),
        builder: (context, snapshot) {
          List<Product> products = [];
          if (snapshot.hasData) {
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              products.add(Product(
                productID: doc.documentID,
                productPrice: data[kProductPrice],
                productImageLocation: data[kProductImageLocation],
                productDescription: data[kProductDescription],
                productCategory: data[kProductCategory],
                productName: data[kProductName],
              ));
            }
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: GestureDetector(
                          onTapUp: (details)
                          {
                            double dx = details.globalPosition.dx ;
                            double dy = details.globalPosition.dy;
                            double dx1 = MediaQuery.of(context).size.width - dx ;
                            double dy1 = MediaQuery.of(context).size.width - dy ;
                            showMenu(context: context, position:RelativeRect.fromLTRB(dx, dy, dx1, dy1) , items:[
                              MyPopUpMenuItem(
                                child: Text("Edit"),
                                onClick: ()
                                {
                                  Navigator.pushNamed(context, ModifyProduct.id , arguments:products[index] );
                                },

                              ),
                              MyPopUpMenuItem(
                                child: Text("delete"),
                                onClick: ()
                                {
                                  _store.deleteProduct(products[index].productID);
                                  Navigator.pop(context);
                                },
                              ),
                            ] );

                          },
                          child: Card(
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            child: Image(
                              image: ExactAssetImage(
                                  products[index].productImageLocation),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .5,
                          child: Container(
                            height: 50,
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[index].productName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Text(products[index].productPrice + "\$" ,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: products.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}


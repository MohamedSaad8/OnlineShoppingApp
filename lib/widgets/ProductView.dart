import 'package:flutter/material.dart';
import 'package:onlineshoppingapp/Models/ProductModal.dart';
import 'package:onlineshoppingapp/screens/productInfo.dart';
import '../getProductCategory.dart';

Widget productViewByCategoryName(String category ,List<Product> allProducts) {
  List<Product> products =getProductByCategory(category, allProducts);
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
                onTap: ()
                  {
                    Navigator.pushNamed(context, ProductInfo.id, arguments: products[index]);
                  }
                ,
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
}
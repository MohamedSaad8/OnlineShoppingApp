import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshoppingapp/Models/ProductModal.dart';
import 'package:onlineshoppingapp/constants.dart';
import 'package:onlineshoppingapp/provider/cartProducts.dart';
import 'package:onlineshoppingapp/screens/productInfo.dart';
import 'package:onlineshoppingapp/services/store.dart';
import 'package:onlineshoppingapp/widgets/customMenu.dart';
import 'package:provider/provider.dart';

import 'AdminScreens/editProduct.dart';

class CartScreen extends StatelessWidget {
  static String id = "cartScreen";

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartProduct>(context).products;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenheight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "my cart".toUpperCase(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constrain) {
              if (products.isNotEmpty) {
                return Container(
                  height: screenheight -
                      appBarHeight -
                      statusBarHeight -
                      (screenheight * .1),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: GestureDetector(
                          onTapUp: (details) {
                            showMenuToEdit(details, context, products[index]);
                          },
                          child: Container(
                            width: screenWidth,
                            height: screenheight * .15,
                            color: kMAinColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage: ExactAssetImage(
                                          products[index].productImageLocation),
                                      radius: screenheight * .15 / 2,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Text(
                                            products[index]
                                                .productName
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0),
                                          child: Text(
                                            products[index]
                                                    .productPrice
                                                    .toUpperCase() +
                                                "\$",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    products[index].quantity.toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: products.length,
                  ),
                );
              } else {
                return Container(
                  height: screenheight -
                      (screenheight * .1) -
                      (appBarHeight) -
                      statusBarHeight,
                  child: Center(
                    child: (Text(
                      "Your Cart Is Empty",
                      style: TextStyle(fontSize: 16),
                    )),
                  ),
                );
              }
            },
          ),
          Builder(
            builder:(context) => ButtonTheme(
              minWidth: screenWidth,
              height: screenheight * .1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: RaisedButton(
                color: kMAinColor,
                child: Text(
                  "Order".toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                onPressed: () {
                  showCustomDailog(context, products);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  showMenuToEdit(details, context, Product product) {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx1 = MediaQuery.of(context).size.width - dx;
    double dy1 = MediaQuery.of(context).size.width - dy;
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx1, dy1),
        items: [
          MyPopUpMenuItem(
            child: Text("Edit"),
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartProduct>(context, listen: false)
                  .removeProduct(product);
              Navigator.pushNamed(context, ProductInfo.id, arguments: product);
            },
          ),
          MyPopUpMenuItem(
            child: Text("delete"),
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartProduct>(context, listen: false)
                  .removeProduct(product);
            },
          ),
        ]);
  }

  void showCustomDailog(context, List<Product> products) async {
    int price = getTotalPrice(products);
    String address;
    AlertDialog alertDialog = AlertDialog(
      title: Text("Total Price is $price \$"),
      content: TextField(
        onChanged: (value) {
          address = value;
        },
        decoration: InputDecoration(hintText: "Enter your Address"),
      ),
      actions: <Widget>[
        MaterialButton(
          child: Text("confirm"),
          onPressed: () {
           try{
             Store _store = Store();
             _store.addOrders({kAddress: address, kTotalPrice: price}, products);
             Scaffold.of(context).showSnackBar(SnackBar(content: Text("Successfull"),));
             Navigator.pop(context);
           }catch (ex)
            {
              print(ex.message);
            }
          },
        )
      ],
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  int getTotalPrice(List<Product> products) {
    int price = 0;
    for (var product in products) {
      price += int.parse(product.productPrice) * product.quantity;
    }
    return price;
  }
}

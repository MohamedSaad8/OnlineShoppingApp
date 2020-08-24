import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshoppingapp/Models/ProductModal.dart';
import 'package:onlineshoppingapp/constants.dart';
import 'package:onlineshoppingapp/provider/cartProducts.dart';
import 'package:onlineshoppingapp/screens/cartscreen.dart';
import 'package:provider/provider.dart';
class ProductInfo extends StatefulWidget {
  static String id = "product info";

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1 ;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image(
              image: ExactAssetImage(product.productImageLocation),
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(child: Icon(Icons.arrow_back_ios),
                  onTap: (){
                    Navigator.pop(context) ;
                  },),
                  GestureDetector(child: Icon(Icons.shopping_cart),
                  onTap: (){
                    Navigator.pushNamed(context, CartScreen.id);
                  },)
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: <Widget>[
                Opacity(
                  opacity: .5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .25,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.productName,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "\$ ${product.productPrice}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            product.productDescription,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                child: Material(
                                  color: kMAinColor,
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _quantity++;
                                      });
                                    },
                                    child: SizedBox(
                                      height: 28,
                                      width: 28,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ),
                              ),
                              Text(_quantity.toString(),
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold
                              ),),
                              ClipOval(
                                child: Material(
                                  color: kMAinColor,
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _quantity > 1 ? _quantity-- : null ;
                                      });
                                    },
                                    child: SizedBox(
                                      height: 28,
                                      width: 28,
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) => ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    buttonColor: kMAinColor,
                    child: RaisedButton(
                      onPressed: () {
                        addToCart(context, product);
                      },
                      child: Text(
                        "add to card".toUpperCase(),
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addToCart(BuildContext context, Product product) {
     CartProduct cartProduct = Provider.of<CartProduct>(context , listen: false) ;
     List<Product> product1 = cartProduct.products;
     bool exist = false ;
    product.quantity =_quantity ;

    for(var item in product1)
      {
        if(item.productName == product.productName)
          {
            exist = true ;

          }
      }
    if(exist)
      {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("this item is added befor"),));
      }
    else
    {
      cartProduct.addProduct(product);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Done added to cart"),));
    }

  }
}

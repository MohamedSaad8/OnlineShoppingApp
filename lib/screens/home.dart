import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshoppingapp/Models/ProductModal.dart';
import 'package:onlineshoppingapp/constants.dart';
import 'package:onlineshoppingapp/provider/modalHUD.dart';
import 'package:onlineshoppingapp/screens/cartscreen.dart';
import 'package:onlineshoppingapp/screens/login_screen.dart';
import 'package:onlineshoppingapp/screens/productInfo.dart';
import 'package:onlineshoppingapp/services/auth.dart';
import 'package:onlineshoppingapp/services/store.dart';
import 'package:onlineshoppingapp/widgets/ProductView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../getProductCategory.dart';

class Home extends StatefulWidget {
  static String id = "HomeScreen";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int indicatorIndex = 0;
  int bottomBarIndex = 0 ;
  final _store = Store() ;
  Auth _auth = Auth() ;
  List<Product> _allProducts = [] ;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: bottomBarIndex,
              unselectedItemColor: kUnActiveMode,
              fixedColor: kMAinColor,
              onTap: (value) async
              {
                if(value == 2)
                  {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    _auth.signOut();
                    Provider.of<ModalHUD>(context ,listen: false).changeIsLoading(false);
                    Navigator.popAndPushNamed(context, LoginScreen.id);

                  }
                setState(() {
                  bottomBarIndex = value ;
                });
              },
              items: [
                BottomNavigationBarItem(
                  title: Text("Test"),
                  icon: Icon(Icons.person)
                ),
                BottomNavigationBarItem(
                    title: Text("Test"),
                    icon: Icon(Icons.person)
                ),
                BottomNavigationBarItem(
                    title: Text("Log Out"),
                    icon: Icon(Icons.close)
                ),

              ],
            ),
            appBar: AppBar(

              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: kMAinColor,
                onTap: (value) {
                  setState(() {
                    indicatorIndex = value;
                  });
                },
                tabs: <Widget>[
                  Text(
                    "Jakets",
                    style: TextStyle(
                        color:
                            indicatorIndex == 0 ? Colors.black : kUnActiveMode,
                        fontSize: indicatorIndex == 0 ? 18 : null,
                        fontWeight: FontWeight.bold),
                  ),
                  Text("Trousere",
                    style: TextStyle(
                        color:
                        indicatorIndex == 1 ? Colors.black :kUnActiveMode ,
                        fontSize: indicatorIndex == 1 ? 16 : null,
                        fontWeight: FontWeight.bold),
                  ),
                  Text("T-shirt",
                    style: TextStyle(
                        color:
                        indicatorIndex == 2 ? Colors.black : kUnActiveMode,
                        fontSize: indicatorIndex == 2 ? 18 : null,
                        fontWeight: FontWeight.bold),),
                  Text("Shoes" , style: TextStyle(
                      color:
                      indicatorIndex == 3 ? Colors.black : kUnActiveMode,
                      fontSize: indicatorIndex == 3 ? 18 : null,
                      fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: TabBarView(

                children: <Widget>[
                  jacketsTab(),
                  productViewByCategoryName(kTrousers,_allProducts),
                  productViewByCategoryName(kT_Shirt,_allProducts),
                  productViewByCategoryName(kShose,_allProducts),
                ],
              ),
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height*.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("discover".toUpperCase() ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                    child: Icon(
                      Icons.shopping_cart
                    ),
                  )

                ],
              ),
            ),
          ),

        )
      ],
    );
  }
 Widget jacketsTab() {
    return StreamBuilder(
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
          _allProducts = [...products];
          products.clear();
          products = getProductByCategory(kJackets , _allProducts);
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
    );
 }

}

import 'package:flutter/material.dart';
import 'package:onlineshoppingapp/constants.dart';
import 'package:onlineshoppingapp/provider/UserMode.dart';
import 'package:onlineshoppingapp/provider/cartProducts.dart';
import 'package:onlineshoppingapp/provider/modalHUD.dart';
import 'package:onlineshoppingapp/screens/AdminHome.dart';
import 'package:onlineshoppingapp/screens/AdminScreens/OrdersScreen.dart';
import 'package:onlineshoppingapp/screens/AdminScreens/addProduct.dart';
import 'package:onlineshoppingapp/screens/AdminScreens/editProduct.dart';
import 'package:onlineshoppingapp/screens/AdminScreens/modifyproduct.dart';
import 'package:onlineshoppingapp/screens/Signup.dart';
import 'package:onlineshoppingapp/screens/cartscreen.dart';
import 'package:onlineshoppingapp/screens/home.dart';
import 'package:onlineshoppingapp/screens/login_screen.dart';
import 'package:onlineshoppingapp/screens/productInfo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()=>runApp(OnlineShopping());

class OnlineShopping extends StatelessWidget {
  bool isLogin = false ;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context , snapshot)
      {
        if(!snapshot.hasData)
          {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        else
          {
            isLogin = snapshot.data.getBool(kKeepMeLogin) ?? false;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ModalHUD>(
                  create: (context)=>ModalHUD(),
                ),
                ChangeNotifierProvider<UserMode>(
                  create: (context)=>UserMode(),
                ),
                ChangeNotifierProvider<CartProduct>(
                  create: (context)=>CartProduct(),
                )
              ],
              child: MaterialApp(
                initialRoute:isLogin == true ? Home.id : LoginScreen.id ,
                routes: {
                  CartScreen.id : (context) =>CartScreen(),
                  LoginScreen.id : (context) => LoginScreen(),
                  SignUpScreen.id : (context) => SignUpScreen(),
                  Home.id : (context) =>Home(),
                  AdminHome.id : (context)=> AdminHome(),
                  AddProduct.id : (context)=>AddProduct(),
                  EditProduct.id : (context) =>EditProduct(),
                  ModifyProduct.id :(context)=>ModifyProduct(),
                  ProductInfo.id : (context)=>ProductInfo(),
                  OrderScreen.id : (context) => OrderScreen()
                },
              ),
            );
          }
      },
    );
  }
}

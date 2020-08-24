import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineshoppingapp/constants.dart';
import 'package:onlineshoppingapp/provider/UserMode.dart';
import 'package:onlineshoppingapp/provider/modalHUD.dart';
import 'package:onlineshoppingapp/screens/AdminHome.dart';
import 'package:onlineshoppingapp/services/auth.dart';
import 'package:onlineshoppingapp/widgets/custom_text_filed.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Signup.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _email, _password;
  final _auth = Auth();
  bool isLoginedIn = false ;

  @override
  Widget build(BuildContext context) {
    var heigh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kMAinColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHUD>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(
                        image: ExactAssetImage("images/icons/BuyIT.png"),
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          "Buy it",
                          style:
                              TextStyle(fontFamily: "pacifico", fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: heigh * .1,
              ),
              CustomTextFiled(
                hint: "Enter your Email",
                icon: Icons.email,
                fun: (value) {
                  _email = value;
                },
              ),
              SizedBox(
                height: heigh * .02,
              ),
              CustomTextFiled(
                hint: "Enter your Passward",
                icon: Icons.lock,
                fun: (value) {
                  _password = value;
                },
              ),
             Padding(
               padding: const EdgeInsets.only(left: 20),
               child: Row(
                 children: <Widget>[
                   Theme(
                     data: ThemeData(
                       unselectedWidgetColor: kSecondaryColor,

                     ),
                     child: Checkbox(
                       activeColor: kMAinColor,
                       value: isLoginedIn,
                       onChanged: (value){
                         setState(() {
                           isLoginedIn = value ;
                         });
                       },
                     ),
                   ),
                   Text("Keep me login"
                   ,style: TextStyle(color: kSecondaryColor),
                   )
                 ],
               ),
             ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      _validating(context);
                      if(isLoginedIn)
                        {
                          keepMeLogined();
                        }

                    },
                    color: Colors.black,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: heigh * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        final userMode =
                            Provider.of<UserMode>(context, listen: false);
                        userMode.changeMode(true);
                      },
                      child: Text(
                        "I am admin",
                        style: TextStyle(
                            fontSize: 18,
                            color: Provider.of<UserMode>(context).isAdmin
                                ? kMAinColor
                                : Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final userMode =
                            Provider.of<UserMode>(context, listen: false);
                        userMode.changeMode(false);
                      },
                      child: Text(
                        "I am a User",
                        style: TextStyle(
                            fontSize: 18,
                            color: Provider.of<UserMode>(context).isAdmin
                                ? Colors.white
                                : kMAinColor),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validating(BuildContext context) async {
    final modalHUD = Provider.of<ModalHUD>(context, listen: false);

    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      modalHUD.changeIsLoading(true);
      if (Provider.of<UserMode>(context , listen: false).isAdmin) {
        if (_password == "admin1234") {
          try {
            await _auth.signIn(_email.trim(), _password.trim());

            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modalHUD.changeIsLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        }else{
          modalHUD.changeIsLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("that is a worng thing"),
          ));
        }
      } else {
        try {
          await _auth.signIn(_email, _password);
          Navigator.pushNamed(context, Home.id);
        } catch (e) {
          modalHUD.changeIsLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
  }

  void keepMeLogined() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(kKeepMeLogin,isLoginedIn );
  }
}

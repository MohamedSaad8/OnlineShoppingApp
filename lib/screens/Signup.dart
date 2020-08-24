import 'package:flutter/material.dart';
import 'package:onlineshoppingapp/provider/modalHUD.dart';
import 'package:onlineshoppingapp/screens/home.dart';
import 'package:onlineshoppingapp/screens/login_screen.dart';
import 'package:onlineshoppingapp/services/auth.dart';
import 'package:onlineshoppingapp/widgets/custom_text_filed.dart';
import '../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  static String id = "SignUp" ;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _email , _password ;
    final _auth = Auth();
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
                          style: TextStyle(fontFamily: "pacifico", fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: heigh*.1,
              ),
              CustomTextFiled(
                hint: "Enter your Name",
                icon: Icons.person,
              ),
              SizedBox(
                height: heigh*.02,
              ),
              CustomTextFiled(
                hint: "Enter your Email",
                icon: Icons.email,
                fun: (value)
                {
                  _email = value ;
                },
              ),
              SizedBox(
                height: heigh*.02,
              ),
              CustomTextFiled(
                hint: "Enter your Passward",
                icon: Icons.lock,
                fun: (value)
                {
                  _password = value;
                },
              ),
              SizedBox(
                height: heigh*.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context)=> FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    onPressed: () async {
                      final modalHUD = Provider.of<ModalHUD>(context,listen: false);
                      if(_globalKey.currentState.validate())
                        {
                          modalHUD.changeIsLoading(true);
                          try
                              {
                                _globalKey.currentState.save();
                                final authResult = await _auth.signUp(_email, _password);
                                print(authResult.user.uid);
                                modalHUD.changeIsLoading(false);
                                Navigator.pushNamed(context, Home.id);
                              }
                              catch (e){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 30),
                              content: Text(e.message),

                            ));
                            modalHUD.changeIsLoading(false);

                              }


                        }
                    },
                    color: Colors.black,
                    child: Text(
                      "SignUP",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: heigh*.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Do have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.black,fontSize: 18),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

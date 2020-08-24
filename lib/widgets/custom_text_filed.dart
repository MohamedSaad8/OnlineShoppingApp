import 'package:flutter/material.dart';
import '../constants.dart';

class CustomTextFiled extends StatelessWidget {
  final String hint ;
  final IconData icon ;
  final Function fun ;

  String handleError (String str)
  {
    switch(hint)
    {
      case "Enter your Name" : return "Name is Empty" ;
      case "Enter your Email" : return "Email is Empty" ;
      case "Enter your Passward" : return "Password is Empty" ;

    }
  }


  CustomTextFiled({@required this.hint, @required this.icon ,@required this.fun});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value)
        {
          if(value.isEmpty)
            {
              // ignore: missing_return
              return handleError(hint) ;
            }
        },
        onSaved: fun,
        cursorColor: kMAinColor,
        obscureText: hint == "Enter your Passward" ? true : false,
        decoration: InputDecoration(
            prefixIcon: Icon(icon, color: kMAinColor,),
            hintText: hint,

            filled: true,
            fillColor: kSecondaryColor,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color:Colors.white,
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color:Colors.white,
                )
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color:Colors.white,
                )
            ),
        ),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';

class UserMode extends ChangeNotifier
{
  bool isAdmin = false ;
  changeMode(bool val)
  {
    isAdmin =val;
    notifyListeners();
  }
}
import 'package:flutter/cupertino.dart';

class ModalHUD extends ChangeNotifier
{
  bool isLoading = false ;
  changeIsLoading (bool value)
  {
    isLoading =value;
    notifyListeners();
  }

}
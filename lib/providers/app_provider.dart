import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppProvider with ChangeNotifier {
  int currentTab = 0;
  bool isNavOpen = false;
  bool isLoggedIn = false;
  bool isEnglish = true;
  String tempMobileNumber = '';

  void setCurrentPage(int page) {
    currentTab = page;
    notifyListeners();
  }

  int get getCurrentPage {
    return currentTab;
  }

  void toggleNavOpen() {
    isNavOpen = !isNavOpen;
    notifyListeners();
  }

  bool get getIsNavOpen {
    return isNavOpen;
  }

  void setIsLoggedIn(bool value) {
    isLoggedIn = value;
    notifyListeners();
  }

  bool get getBoolIsLoggedIn {
    return isLoggedIn;
  }

  void toggleLanguage() {
    isEnglish = !isEnglish;
    notifyListeners();
  }

  bool get getIsEnglish {
    return isEnglish;
  }

  void setTempMobileNumber(String val){
    tempMobileNumber = val;
    notifyListeners();
  }

  String getTempMobileNumber(){
    return tempMobileNumber;
  }
}

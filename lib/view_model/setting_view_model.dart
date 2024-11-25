import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingViewModel with ChangeNotifier {
 int notificationCount=0;

 void setNotificationCount(int data) {
   notificationCount=data;
   notifyListeners();
 }

 int get getNotificationCount {
   return notificationCount;
 }

  void setData(dynamic data) {
    notifyListeners();
  }
}


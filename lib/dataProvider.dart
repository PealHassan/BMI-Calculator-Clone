import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataProvider extends ChangeNotifier {
  String selectedWeight = 'kg';

  

  void setWeightData(String data) {
    selectedWeight = data;
    notifyListeners();
  }
}

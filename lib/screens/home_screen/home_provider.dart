import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier{
  bool? isDelivered=false  ;
  bool get isChecked => isDelivered!;
   isDeliveredToggle(bool value){
    isDelivered=value;
    notifyListeners();
   }
   
  }

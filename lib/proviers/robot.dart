import 'package:flutter/material.dart';

class Robot with ChangeNotifier {
  double _linearVel = 0; // ms-1
  double _angularVel = 0; // rads-1
  double _linearMax = 1; // ms-1
  double _angularMax = 1; // rads-1

  void setLinearVel(double val) {
    _linearVel = val;
    notifyListeners();
  }

  double getLinearVel() {
    return _linearVel;
  }

  void setAngularVel(double val) {
    _angularVel = val;
    notifyListeners();
  }

  double getAngularVel() {
    return _angularVel;
  }

  void setLinearMax(double val) {
    _linearMax = val;
    notifyListeners();
  }

  double getLinearMax() {
    return _linearMax;
  }

  void setAngularMax(double val) {
    _angularMax = val;
    notifyListeners();
  }

  double getAngularMax() {
    return _angularMax;
  }
}

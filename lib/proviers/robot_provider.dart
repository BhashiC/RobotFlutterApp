import 'package:flutter/material.dart';
import './led_provider.dart';

class RobotProvider with ChangeNotifier {
  bool _redLedStatus = false;
  bool _whiteLedStatus = false;
  bool _yellowLedStatus = false;
  bool _blueLedStatus = false;

  double _linearVel = 0; // ms-1
  double _angularVel = 0; // rads-1
  double _linearMax = 1; // ms-1
  double _angularMax = 1; // rads-1

  bool get redLedStatus => _redLedStatus;
  bool get whiteLedStatus => _whiteLedStatus;
  bool get yellowLedStatus => _yellowLedStatus;
  bool get blueLedStatus => _blueLedStatus;
  double get linearVel => _linearVel;
  double get angularVel => _angularVel;
  double get linearMax => _linearMax;
  double get angularMax => _angularMax;

  List<LedProvider> leds = [
    new LedProvider("Blue", Colors.blue),
    new LedProvider("Red", Colors.red),
    new LedProvider("Yellow", Colors.orange),
    new LedProvider("White", Colors.lime),
  ];

  set redLedStatus(bool val) {
    _redLedStatus = val;
    notifyListeners();
  }

  set whiteLedStatus(bool val) {
    _whiteLedStatus = val;
    notifyListeners();
  }

  set yellowLedStatus(bool val) {
    _yellowLedStatus = val;
    notifyListeners();
  }

  set blueLedStatus(bool val) {
    _blueLedStatus = val;
    notifyListeners();
  }

  set linearVel(double val) {
    _linearVel = val;
    notifyListeners();
  }

  set angularVel(double val) {
    _angularVel = val;
    notifyListeners();
  }

  set linearMax(double val) {
    _linearMax = val;
    notifyListeners();
  }

  set angularMax(double val) {
    _angularMax = val;
    notifyListeners();
  }
}

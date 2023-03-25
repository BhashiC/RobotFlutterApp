import 'package:flutter/material.dart';
import 'package:robot_app/proviers/comp_base_provider.dart';

class SliderProvider extends CompBaseProvider {
  double _minVal = 0;
  double _maxVal = 100;
  double _currentVal = 0;

  double get minVal => _minVal;
  double get maxVal => _maxVal;
  double get currentVal => _currentVal;

  set minVal(double val) {
    if (_maxVal < val) {
      return;
    }
    _minVal = val;
    if (_currentVal < _minVal) {
      _currentVal = _minVal;
    }
    notifyListeners();
  }

  set maxVal(double val) {
    if (_minVal > val) {
      return;
    }
    _maxVal = val;
    if (_currentVal > _maxVal) {
      _currentVal = _maxVal;
    }
    notifyListeners();
  }

  set currentVal(double val) {
    _currentVal = val;
    notifyListeners();
  }

  SliderProvider(
      String displayName, String connectivityName, this._minVal, this._maxVal)
      : super(displayName, connectivityName);
}

import 'package:flutter/material.dart';
import 'package:robot_app/proviers/comp_base_provider.dart';
import './slider_provider.dart';

class ServoProvider extends CompBaseProvider {
  double _minVal = 0;
  double _maxVal = 180;

  SliderProvider servoSlider = new SliderProvider("", "", 0, 180);

  ServoProvider(
      String displayName, String connectivityName, this._minVal, this._maxVal)
      : super(displayName, connectivityName) {
    servoSlider =
        new SliderProvider(displayName, connectivityName, _minVal, _maxVal);
  }
}

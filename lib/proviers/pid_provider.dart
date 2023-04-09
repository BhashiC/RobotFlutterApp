import 'package:flutter/material.dart';
import 'package:robot_app/proviers/comp_base_provider.dart';
import './slider_provider.dart';

class PidProvider extends CompBaseProvider {
  List<SliderProvider> pidSliders = [
    SliderProvider("Proportional (Kp)", "Kp", 0, 10),
    SliderProvider("Integral (Ki)", "Ki", 0, 0.5),
    SliderProvider("Derivative (Kd)", "Kd", 0, 1),
  ];

  PidProvider(String displayName, String connectivityName)
      : super(displayName, connectivityName);
}

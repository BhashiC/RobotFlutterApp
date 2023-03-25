import 'package:flutter/material.dart';
import 'package:robot_app/proviers/comp_base_provider.dart';

class LedProvider extends CompBaseProvider {
  bool _ledStatus = false;
  final Color _color;

  bool get ledStatus => _ledStatus;
  Color get color => _color;

  set ledStatus(bool val) {
    _ledStatus = val;
    notifyListeners();
  }

  LedProvider(String displayName, String connectivityName, this._color)
      : super(displayName, connectivityName);
}

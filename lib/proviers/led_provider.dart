import 'package:flutter/material.dart';

class LedProvider with ChangeNotifier {
  final String _name;
  final Color _color;
  bool _ledStatus = false;

  String get name => _name;
  Color get color => _color;
  bool get ledStatus => _ledStatus;

  set ledStatus(bool val) {
    _ledStatus = val;
    notifyListeners();
  }

  LedProvider(this._name, this._color);
}

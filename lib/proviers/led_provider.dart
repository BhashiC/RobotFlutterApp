import 'package:flutter/material.dart';

class LedProvider with ChangeNotifier {
  final String _displayName;
  final String _connectivityName;
  final Color _color;
  bool _ledStatus = false;

  String get displayName => _displayName;
  String get connectivityName => _connectivityName;
  Color get color => _color;
  bool get ledStatus => _ledStatus;

  set ledStatus(bool val) {
    _ledStatus = val;
    notifyListeners();
  }

  LedProvider(this._displayName, this._connectivityName, this._color);
}

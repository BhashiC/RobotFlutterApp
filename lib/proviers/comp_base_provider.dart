import 'package:flutter/material.dart';

class CompBaseProvider with ChangeNotifier {
  final String _displayName;
  final String _connectivityName;

  String get displayName => _displayName;
  String get connectivityName => _connectivityName;

  CompBaseProvider(this._displayName, this._connectivityName);
}

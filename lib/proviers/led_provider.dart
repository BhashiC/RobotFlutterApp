import 'package:flutter/material.dart';

class ledProvider with ChangeNotifier {
  bool _ledStatus = false;

  set ledStatus(bool status) {
    _ledStatus = status;
  }

  bool get ledStatus => _ledStatus;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

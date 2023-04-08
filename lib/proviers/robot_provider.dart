import 'dart:io';

import 'package:flutter/material.dart';
import 'package:robot_app/proviers/pid_provider.dart';
import 'package:robot_app/proviers/web_socket_provider.dart';
import './led_provider.dart';
import './pid_provider.dart';

class RobotProvider with ChangeNotifier {
  static RobotProvider? _instance;

  RobotProvider._internal() {
    SetupWebSocket();
  }

  static RobotProvider get instance {
    _instance ??= RobotProvider._internal();
    return _instance!;
  }

  late WebSocketProvider _webSocket;
  WebSocketProvider get WebSocket => _webSocket;

  SetupWebSocket() {
    _webSocket =
        new WebSocketProvider(this._webSocketIpAddress, this._webSocketPort);
  }

  String _webSocketIpAddress = "192.168.1.100";
  String _webSocketPort = "81";

  double _linearVel = 0; // ms-1
  double _angularVel = 0; // rads-1
  double _linearMax = 1; // ms-1
  double _angularMax = 1; // rads-1

  double get linearVel => _linearVel;
  double get angularVel => _angularVel;
  double get linearMax => _linearMax;
  double get angularMax => _angularMax;

  List<LedProvider> leds = [
    LedProvider("Blue", "blue_led", Colors.blue),
    LedProvider("Yellow", "yellow_led", Colors.orange),
    LedProvider("White", "white_led", Colors.lime),
    LedProvider("Red", "red_led", Colors.red),
  ];

  List<PidProvider> pids = [
    PidProvider("Left Motor", "Left_M"),
    PidProvider("Right Motor", "Right_M"),
  ];

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

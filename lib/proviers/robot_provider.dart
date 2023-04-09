import 'package:flutter/material.dart';
import 'package:robot_app/enums.dart';
import 'package:robot_app/extensions.dart';
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
    LedProvider(DisplayNames.blue.toHeadingString(),
        ConnectivityNames.blue_led.toShortString(), Colors.blue),
    LedProvider(DisplayNames.yellow.toHeadingString(),
        ConnectivityNames.yellow_led.toShortString(), Colors.orange),
    LedProvider(DisplayNames.white.toHeadingString(),
        ConnectivityNames.white_led.toShortString(), Colors.lime),
    LedProvider(DisplayNames.red.toHeadingString(),
        ConnectivityNames.red_led.toShortString(), Colors.red),
  ];

  List<PidProvider> pids = [
    PidProvider(DisplayNames.left_motor.toHeadingString(),
        ConnectivityNames.left_m.toShortString()),
    PidProvider(DisplayNames.right_motor.toHeadingString(),
        ConnectivityNames.right_m.toShortString()),
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

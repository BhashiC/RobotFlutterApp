import 'dart:io';
import 'package:flutter/material.dart';
import 'package:robot_app/main.dart';
import 'package:robot_app/proviers/robot_provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
//import 'package:web_socket_channel/status.dart' as status;

class WebSocketManager with ChangeNotifier {
  static WebSocketManager? _instance;
  static WebSocketChannel? _channel;
  String _receivedMsg = "";

  String get receivedMessage => _receivedMsg;

  set _receivedMessage(String val) {
    _receivedMsg = val;
    notifyListeners();
  }

  WebSocketManager._internal() {
    _channel = IOWebSocketChannel.connect('ws://192.168.1.100:81');
  }

  static WebSocketManager get instance {
    _instance ??= WebSocketManager._internal();
    return _instance!;
  }

  void sendMsgAndUpdateUI(String message) {
    if (_channel != null && _channel!.sink != null) {
      _channel!.sink.add(message);
    }
    updateSensors();
  }

  _updateRobotProperties(String msg) {
    var msglist = msg.toString().split(",").toList();
    if (msglist.contains("blue_1")) {
      RobotProvider.instance.leds
          .firstWhere((element) => element.displayName == "Blue")
          .ledStatus = true;
    }
    if (msglist.contains("blue_0")) {
      RobotProvider.instance.leds
          .firstWhere((element) => element.displayName == "Blue")
          .ledStatus = false;
    }
    if (msglist.contains("yellow_1")) {
      RobotProvider.instance.leds
          .firstWhere((element) => element.displayName == "Yellow")
          .ledStatus = true;
    }
    if (msglist.contains("yellow_0")) {
      RobotProvider.instance.leds
          .firstWhere((element) => element.displayName == "Yellow")
          .ledStatus = false;
    }
    if (msglist.contains("white_1")) {
      RobotProvider.instance.leds
          .firstWhere((element) => element.displayName == "White")
          .ledStatus = true;
    }
    if (msglist.contains("white_0")) {
      RobotProvider.instance.leds
          .firstWhere((element) => element.displayName == "White")
          .ledStatus = false;
    }
    if (msglist.contains("red_1")) {
      RobotProvider.instance.leds
          .firstWhere((element) => element.displayName == "Red")
          .ledStatus = true;
    }
    if (msglist.contains("red_0")) {
      RobotProvider.instance.leds
          .firstWhere((element) => element.displayName == "Red")
          .ledStatus = false;
    }
  }

  updateSensors([String msgin = ""]) {
    try {
      if (_channel != null && _channel!.sink != null) {
        if (msgin == "") {
          _channel!.sink.add("update_sensors");
        } else {
          _channel!.sink.add(msgin);
        }
        _channel!.stream.listen((data) {
          String msg = data;
          _receivedMessage = msg;
          _updateRobotProperties(msg);
        }, onError: (error) {
          _receivedMessage = error;
        });
      }
    } catch (ex) {
      // ex is throwing since we are listen to the same channel again
      // it is fine since we are opening one channel for a device based on our plan
    }
  }

  void dispose() {
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
    }
  }
}

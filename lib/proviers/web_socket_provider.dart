import 'dart:io';
import 'package:flutter/material.dart';
import 'package:robot_app/main.dart';
import 'package:robot_app/proviers/robot_provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
//import 'package:web_socket_channel/status.dart' as status;

class WebSocketProvider with ChangeNotifier {
  static WebSocketProvider? _instance;
  static WebSocketChannel? _channel;
  String _receivedMsg = "";
  String _ipAddress = "";
  String _port = "";

  String get receivedMessage => _receivedMsg;
  String get ipAddress => _ipAddress;
  String get port => _port;

  set receivedMessage(String val) {
    _receivedMsg = val;
    notifyListeners();
  }

  set ipAddress(String val) {
    _ipAddress = val;
    notifyListeners();
  }

  set port(String val) {
    _port = val;
    notifyListeners();
  }

  WebSocketProvider(this._ipAddress, this._port) {
    Connect();
  }

  WebSocketProvider._internal() {
    //_channel = IOWebSocketChannel.connect('ws://${_ipAddress}:${_port}');
    _channel = IOWebSocketChannel.connect('ws://192.168.1.100:81');
  }

  // static WebSocketProvider get instance {
  //   _instance ??= WebSocketProvider._internal();
  //   return _instance!;
  // }

  void Connect() {
    dispose();
    if (_ipAddress.isEmpty || _port.isEmpty) {
      return;
    }
    print("Connecting... ip: $_ipAddress port: $_port");
    _channel = IOWebSocketChannel.connect('ws://$_ipAddress:$_port');
    print("Connected!");
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
          print(msg);
          receivedMessage = msg;
          _updateRobotProperties(msg);
        }, onError: (error) {
          receivedMessage = error;
        });
      }
    } catch (ex) {
      // ex is throwing since we are listen to the same channel again
      // it is fine since we are opening one channel for a device based on our plan
    }
  }

  void dispose() {
    if (_channel != null) {
      print("Channel disposing...");
      _channel!.sink.close();
      _channel = null;
      print("Channel disposed");
    }
  }
}

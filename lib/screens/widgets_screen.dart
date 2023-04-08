import 'package:flutter/material.dart';
import 'package:robot_app/proviers/robot_provider.dart';
import 'package:robot_app/proviers/web_socket_provider.dart';
import 'package:enum_to_string/enum_to_string.dart';
import '../widgets/led_widget.dart';
import '../widgets/joystick_widget.dart';
import '../widgets/tile_widget.dart';
import '../enums.dart';

class WidgetsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //WebSocketProvider.instance.updateSensors();
    RobotProvider.instance.WebSocket.updateSensors();
    return Scaffold(
      appBar: AppBar(title: const Text("Robot App")),
      body: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          TileWidget(
            EnumToString.convertToString(WidgetNames.leds, camelCase: true),
            Colors.blue,
            WidgetNames.leds,
          ),
          TileWidget(
            EnumToString.convertToString(WidgetNames.joystick, camelCase: true),
            Colors.orange,
            WidgetNames.joystick,
          ),
          TileWidget(
              EnumToString.convertToString(WidgetNames.pidController,
                  camelCase: true),
              Colors.red,
              WidgetNames.pidController),
          TileWidget(
              EnumToString.convertToString(WidgetNames.servoMotor,
                  camelCase: true),
              Colors.purple,
              WidgetNames.servoMotor),
          TileWidget(
              EnumToString.convertToString(WidgetNames.webSocket,
                  camelCase: true),
              Colors.green,
              WidgetNames.webSocket),
        ],
      ),
    );
  }
}

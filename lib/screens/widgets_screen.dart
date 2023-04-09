import 'package:flutter/material.dart';
import 'package:robot_app/proviers/robot_provider.dart';
import 'package:robot_app/proviers/web_socket_provider.dart';
import '../widgets/led_widget.dart';
import '../widgets/joystick_widget.dart';
import '../widgets/tile_widget.dart';
import '../enums.dart';
import '../extensions.dart';

class WidgetsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            WidgetTileNames.leds.toHeadingString(),
            Colors.blue,
            WidgetTileNames.leds,
          ),
          TileWidget(
            WidgetTileNames.joystick.toHeadingString(),
            Colors.orange,
            WidgetTileNames.joystick,
          ),
          TileWidget(
            WidgetTileNames.pid_controller.toHeadingString(),
            Colors.red,
            WidgetTileNames.pid_controller,
          ),
          TileWidget(
            WidgetTileNames.servo_motor.toHeadingString(),
            Colors.purple,
            WidgetTileNames.servo_motor,
          ),
          TileWidget(
            WidgetTileNames.web_socket.toHeadingString(),
            Colors.green,
            WidgetTileNames.web_socket,
          ),
        ],
      ),
    );
  }
}

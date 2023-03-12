import 'package:flutter/material.dart';
import 'package:robot_app/widgets/websocket_widget.dart';
import '../screens/widgets_screen.dart';
import './joystick_widget.dart';
import './led_widget.dart';
import './pid_widget.dart';
import './servo_widget.dart';
import '../screens/leds_screen.dart';
import '../enums.dart';

class TileWidget extends StatelessWidget {
  final String _title;
  final Color _color;
  final WidgetNames _widgetName;

  TileWidget(this._title, this._color, this._widgetName);

  void selectWidget(BuildContext context, WidgetNames widgetToPop) {
    switch (widgetToPop) {
      case WidgetNames.leds:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return LedsScreen(); //(Colors.blue);
        }));
        break;
      case WidgetNames.joystick:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return JoystickWidget(200);
        }));
        break;
      case WidgetNames.pidController:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return PidWidget();
        }));
        break;
      case WidgetNames.servoMotor:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ServoWidget();
        }));
        break;
      case WidgetNames.webSocket:
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return webSocketWidget();
        }));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectWidget(context, _widgetName),
      splashColor: Colors.black38,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _color.withOpacity(0.5),
              _color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          _title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

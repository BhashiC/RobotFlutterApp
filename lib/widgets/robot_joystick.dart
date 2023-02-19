import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
import 'package:vector_math/vector_math.dart';
import 'package:flutter/src/material/colors.dart' as materialColors;
import 'dart:math';
import '../proviers/robot.dart';
import 'package:provider/provider.dart';

const List<double> speeds = <double>[0.25, 0.5, 0.75, 1.0, 1.25, 1.5];

class RobotJoystick extends StatelessWidget {
  double _linearVel = 0;
  double _angularVel = 0;
  Robot _robot = Robot();
  double _size = 100;

  RobotJoystick(double size) {
    super.key;
    _size = size;
  }

  void _onDirectionChanged(double angleDegree, double normalizedDistance) {
    var angleRadians = radians(angleDegree);
    _linearVel = _robot.getLinearMax() * normalizedDistance * cos(angleRadians);
    _angularVel =
        _robot.getAngularMax() * normalizedDistance * sin(angleRadians);
    _robot.setLinearVel(_linearVel);
    _robot.setAngularVel(_angularVel);
  }

  @override
  Widget build(BuildContext context) {
    _robot = Provider.of<Robot>(context, listen: false);
    return Container(
      width: _size,
      // decoration:
      //     BoxDecoration(border: Border.all(color: materialColors.Colors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: const Text('Linear Velocity (ms-1)'),
          ),
          Container(
            child: Consumer<Robot>(
              builder: (ctx, robot, _) =>
                  Text(robot.getLinearVel().toStringAsFixed(2)),
            ),
          ),
          Container(
            child: const Text('Angular Velocity (rads-1)'),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Consumer<Robot>(
              builder: (ctx, robot, _) =>
                  Text(robot.getAngularVel().toStringAsFixed(2)),
            ),
          ),
          Container(
            child: JoystickView(
              innerCircleColor: materialColors.Colors.black26,
              onDirectionChanged: _onDirectionChanged,
              size: _size,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: const Text('Linear Max Velocity (ms-1)'),
          ),
          Container(
            child: Consumer<Robot>(
              builder: (ctx, robot, _) => DropdownButton(
                items: speeds.map<DropdownMenuItem<double>>((double value) {
                  return DropdownMenuItem<double>(
                    value: value,
                    child: Text(value.toStringAsFixed(2)),
                  );
                }).toList(),
                onChanged: (val) => robot.setLinearMax(val as double),
                value: robot.getLinearMax(),
              ),
            ),
          ),
          Container(
            child: const Text('Angular Max Velocity (rad-1)'),
          ),
          Container(
            child: Consumer<Robot>(
              builder: (ctx, robot, _) => DropdownButton(
                items: speeds.map<DropdownMenuItem<double>>((double value) {
                  return DropdownMenuItem<double>(
                    value: value,
                    child: Text(value.toStringAsFixed(2)),
                  );
                }).toList(),
                onChanged: (val) => robot.setAngularMax(val as double),
                value: robot.getAngularMax(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

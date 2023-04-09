import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
import 'package:vector_math/vector_math.dart';
import 'package:flutter/src/material/colors.dart' as materialColors;
import 'dart:math';
import '../proviers/robot_provider.dart';
import 'package:provider/provider.dart';

const List<double> _speeds = <double>[0.25, 0.5, 0.75, 1.0, 1.25, 1.5];

class JoystickWidget extends StatelessWidget {
  double _linearVel = 0;
  double _angularVel = 0;
  RobotProvider _robot = RobotProvider.instance;
  final double _size;

  JoystickWidget(this._size);

  void _onDirectionChanged(double angleDegree, double normalizedDistance) {
    var angleRadians = radians(angleDegree);
    _linearVel = _robot.linearMax * normalizedDistance * cos(angleRadians);
    _angularVel = _robot.angularMax * normalizedDistance * sin(angleRadians);
    _robot.linearVel = _linearVel;
    _robot.angularVel = _angularVel;
  }

  @override
  Widget build(BuildContext context) {
    print("Joystick Widget Builder");
    _robot = Provider.of<RobotProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Joystick Page"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 10),
                const Text('Linear Velocity (ms-1)'),
                Consumer<RobotProvider>(
                  builder: (ctx, robot, _) =>
                      Text(robot.linearVel.toStringAsFixed(2)),
                ),
                const SizedBox(height: 10),
                const Text('Angular Velocity (rads-1)'),
                Consumer<RobotProvider>(
                  builder: (ctx, robot, _) =>
                      Text(robot.angularVel.toStringAsFixed(2)),
                ),
                const SizedBox(height: 10),
                JoystickView(
                  backgroundColor: Theme.of(context).primaryColor,
                  innerCircleColor: materialColors.Colors.black26,
                  onDirectionChanged: _onDirectionChanged,
                  size: _size,
                ),
                const SizedBox(height: 10),
                const Text('Linear Max Velocity (ms-1)'),
                const SizedBox(height: 10),
                Consumer<RobotProvider>(
                  builder: (ctx, robot, _) => DropdownButton(
                    items:
                        _speeds.map<DropdownMenuItem<double>>((double value) {
                      return DropdownMenuItem<double>(
                        value: value,
                        child: Text(value.toStringAsFixed(2)),
                      );
                    }).toList(),
                    onChanged: (val) => robot.linearMax = val as double,
                    value: robot.linearMax,
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Angular Max Velocity (rad-1)'),
                const SizedBox(height: 10),
                Consumer<RobotProvider>(
                  builder: (ctx, robot, _) => DropdownButton(
                    items:
                        _speeds.map<DropdownMenuItem<double>>((double value) {
                      return DropdownMenuItem<double>(
                        value: value,
                        child: Text(value.toStringAsFixed(2)),
                      );
                    }).toList(),
                    onChanged: (val) => robot.angularMax = val as double,
                    value: robot.angularMax,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

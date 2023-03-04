import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
import 'package:vector_math/vector_math.dart';
import 'package:flutter/src/material/colors.dart' as materialColors;
import 'dart:math';
import '../proviers/joystick_provider.dart';
import 'package:provider/provider.dart';

const List<double> speeds = <double>[0.25, 0.5, 0.75, 1.0, 1.25, 1.5];

class JoystickWidget extends StatelessWidget {
  double _linearVel = 0;
  double _angularVel = 0;
  joystickProvider _joystick = joystickProvider();
  final double _size;

  JoystickWidget(this._size);

  void _onDirectionChanged(double angleDegree, double normalizedDistance) {
    var angleRadians = radians(angleDegree);
    _linearVel =
        _joystick.getLinearMax() * normalizedDistance * cos(angleRadians);
    _angularVel =
        _joystick.getAngularMax() * normalizedDistance * sin(angleRadians);
    _joystick.setLinearVel(_linearVel);
    _joystick.setAngularVel(_angularVel);
  }

  @override
  Widget build(BuildContext context) {
    _joystick = Provider.of<joystickProvider>(context, listen: false);
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
                Consumer<joystickProvider>(
                  builder: (ctx, robot, _) =>
                      Text(robot.getLinearVel().toStringAsFixed(2)),
                ),
                const SizedBox(height: 10),
                const Text('Angular Velocity (rads-1)'),
                Consumer<joystickProvider>(
                  builder: (ctx, robot, _) =>
                      Text(robot.getAngularVel().toStringAsFixed(2)),
                ),
                const SizedBox(height: 10),
                JoystickView(
                  innerCircleColor: materialColors.Colors.black26,
                  onDirectionChanged: _onDirectionChanged,
                  size: _size,
                ),
                const SizedBox(height: 10),
                const Text('Linear Max Velocity (ms-1)'),
                const SizedBox(height: 10),
                Consumer<joystickProvider>(
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
                const SizedBox(height: 10),
                const Text('Angular Max Velocity (rad-1)'),
                const SizedBox(height: 10),
                Consumer<joystickProvider>(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// @dart=2.9
import 'package:flutter/material.dart';
import 'widgets/robot_joystick.dart';
import 'package:provider/provider.dart';
import 'proviers/robot.dart';
import 'package:flutter/src/material/colors.dart' as materialColors;

void main() => runApp(RobotApp());

class RobotApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (create) => Robot(),
      child: MaterialApp(
        title: 'Robot App',
        theme: ThemeData(primarySwatch: Colors.green),
        themeMode: ThemeMode.dark,
        home: Scaffold(
          appBar: AppBar(title: const Text('Robot App')),
          body: Container(
            alignment: Alignment.center,
            //width: 200,
            child: RobotJoystick(250),
          ),
        ),
      ),
    );
  }
}

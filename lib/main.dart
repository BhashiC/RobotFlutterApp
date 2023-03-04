// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart' as materialColors;
import 'package:provider/provider.dart';
import 'proviers/joystick_provider.dart';
import 'proviers/led_provider.dart';
import 'widgets/joystick_widget.dart';
import 'widgets/led_widget.dart';
import 'screens/widgets_screen.dart';

void main() => runApp(RobotApp());

class RobotApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => joystickProvider(),
      //create: (context) => ledProvider(),

      child: MaterialApp(
        title: 'Robot App',
        theme: ThemeData(primarySwatch: Colors.green),
        themeMode: ThemeMode.dark,
        home: WidgetsScreen(),
      ),
    );
  }
}

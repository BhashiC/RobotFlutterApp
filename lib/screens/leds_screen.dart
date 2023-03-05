import 'package:flutter/material.dart';
import '../widgets/led_widget.dart';
import '../proviers/robot_provider.dart';
import 'package:provider/provider.dart';

class LedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _robot = Provider.of<RobotProvider>(context, listen: false);
    print("Led Screen Builder");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Led Page"),
      ),
      body: SafeArea(
        child: Center(
            child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(10.0),
          itemCount: _robot.leds.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: _robot.leds[i],
            child: LedWidget(
              _robot.leds[i].name,
              _robot.leds[i].color,
            ),
          ),
        )),
      ),
    );
  }
}

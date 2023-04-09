import 'package:flutter/material.dart';
import '../widgets/pid_widget.dart';
import '../proviers/robot_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/servo_widget.dart';

class ServosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _robot = Provider.of<RobotProvider>(context, listen: false);
    print("Servo Screen Builder");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servo Page"),
      ),
      body: SafeArea(
        child: Center(
            child: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _robot.servos.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: _robot.servos[i],
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                _robot.servos[i].displayName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green),
              ),
              const SizedBox(
                height: 10,
              ),
              ServoWidget(),
            ]),
          ),
        )),
      ),
    );
  }
}

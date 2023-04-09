import 'package:flutter/material.dart';
import '../widgets/pid_widget.dart';
import '../proviers/robot_provider.dart';
import 'package:provider/provider.dart';

class PidsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _robot = Provider.of<RobotProvider>(context, listen: false);
    print("Pid Screen Builder");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pid Page"),
      ),
      body: SafeArea(
        child: Center(
            child: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: _robot.pids.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: _robot.pids[i],
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                _robot.pids[i].displayName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green),
              ),
              const SizedBox(
                height: 10,
              ),
              PidWidget(),
            ]),
          ),
        )),
      ),
    );
  }
}

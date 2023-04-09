import 'package:flutter/material.dart';
import '../proviers/led_provider.dart';
import 'package:provider/provider.dart';
import 'package:robot_app/proviers/robot_provider.dart';

class LedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var led = Provider.of<LedProvider>(context, listen: false);
    //print(led.displayName + " Builder");
    return Card(
      child: ListTile(
          leading: Text(led.displayName),
          title: Consumer<LedProvider>(
            builder: (ctx, led, _) => (Icon(
              led.ledStatus == true
                  ? Icons.circle_sharp
                  : Icons.circle_outlined,
              color: led.color,
              size: 50,
            )),
          ),
          trailing: ElevatedButton(
            child: const Text('Toggle LED'),
            onPressed: () {
              String msg = "";
              if (led.ledStatus) {
                msg = "${led.connectivityName}_0";
              } else {
                msg = "${led.connectivityName}_1";
              }
              RobotProvider.instance.WebSocket.sendMsgAndUpdateUI(msg);
            },
          )),
    );
  }
}

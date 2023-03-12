import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import '../proviers/led_provider.dart';
import 'package:provider/provider.dart';
import '../globals.dart';

class LedWidget extends StatelessWidget {
  //final channel = IOWebSocketChannel.connect('ws://192.168.1.100:81');
  String _name;
  Color _color;

  LedWidget(this._name, this._color);

  @override
  Widget build(BuildContext context) {
    var led = Provider.of<LedProvider>(context, listen: false);
    print(led.displayName + " Builder");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(led.displayName),
        const SizedBox(height: 10),
        /*
        StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              bool ledState = snapshot.data == '1';
              return ledState == true
                  ? Icon(
                      Icons.circle_sharp,
                      color: _color,
                      size: 50,
                    )
                  : Icon(
                      Icons.circle_outlined,
                      color: _color,
                      size: 50,
                    );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        */
        Consumer<LedProvider>(
          builder: (ctx, led, _) => (Icon(
            led.ledStatus == true ? Icons.circle_sharp : Icons.circle_outlined,
            color: _color,
            size: 50,
          )),
        ),
        const SizedBox(height: 10),
        TextButton(
          child: const Text('Toggle LED'),
          onPressed: () {
            String msg = "";
            if (led.ledStatus) {
              msg = led.connectivityName + "_0";
            } else {
              msg = led.connectivityName + "_1";
            }
            //led.ledStatus = !led.ledStatus;
            WebSocketManager.instance.sendMsgAndUpdateUI(msg);
            //WebSocketManager.instance.updateSensors();
            //print("Status: ${led.ledStatus}");
            //print(WebSocketManager.instance.sendReceiveMessage(msg));
          },
        ),
      ],
    );
  }
}

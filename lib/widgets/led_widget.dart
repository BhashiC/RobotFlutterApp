import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import '../proviers/led_provider.dart';
import 'package:provider/provider.dart';
import '../globals.dart';

class LedWidget extends StatelessWidget {
  final channel = IOWebSocketChannel.connect('ws://192.168.1.100:81');
  String _name;
  Color _color;

  LedWidget(this._name, this._color);

  @override
  Widget build(BuildContext context) {
    var led = Provider.of<LedProvider>(context, listen: false);
    print(led.name + " Builder");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(led.name),
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
        TextButton(
          child: const Text('Toggle LED'),
          onPressed: () {
            print(led.name + " toggled");
            channel.sink.add('toggle_led');
          },
        ),
      ],
    );
  }
}

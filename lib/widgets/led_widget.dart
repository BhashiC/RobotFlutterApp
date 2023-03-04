import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class LedWidget extends StatelessWidget {
  final channel = IOWebSocketChannel.connect('ws://192.168.1.100:81');
  Color _color;

  LedWidget(this._color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Led Page"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'LED state:',
              ),
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
                  channel.sink.add('toggle_led');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

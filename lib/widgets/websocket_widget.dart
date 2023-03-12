import 'package:flutter/material.dart';
import 'package:robot_app/globals.dart';
import 'package:web_socket_channel/io.dart';
import 'package:provider/provider.dart';

class webSocketWidget extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  //final _channel = IOWebSocketChannel.connect('ws://192.168.1.100:81');

  @override
  Widget build(BuildContext context) {
    print("websocket_widget build!");
    return Scaffold(
      appBar: AppBar(
        title: Text("Web Socket"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            Consumer<WebSocketManager>(
              builder: (ctx, webSocketMgr, _) =>
                  Text(webSocketMgr.receivedMessage),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      //WebSocketManager.instance.sendMessage(_controller.text);
      WebSocketManager.instance.updateSensors(_controller.text);
      //WebSocketManager.instance.sendReceiveMessage(_controller.text);
      //_channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    //_channel.sink.close();
    _controller.dispose();
    //super.dispose();
  }
}

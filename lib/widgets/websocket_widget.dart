import 'dart:io';

import 'package:flutter/material.dart';
import 'package:robot_app/proviers/web_socket_provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:provider/provider.dart';
import 'package:robot_app/proviers/robot_provider.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';

class WebSocketWidget extends StatelessWidget {
  final TextEditingController _sendMsgController =
      TextEditingController(text: "");
  final TextEditingController _ipAddressController =
      TextEditingController(text: RobotProvider.instance.WebSocket.ipAddress);
  final TextEditingController _portController =
      TextEditingController(text: RobotProvider.instance.WebSocket.port);

  @override
  Widget build(BuildContext context) {
    print("Web Socket Widget Builder");
    return Scaffold(
      appBar: AppBar(
        title: Text("Web Socket"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Connectivity',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Column(children: [
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _ipAddressController,
                          decoration:
                              const InputDecoration(labelText: 'IP Address'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _portController,
                          decoration: const InputDecoration(labelText: 'Port'),
                        ),
                      ),
                      IconButton(
                          onPressed: () => _connect(),
                          icon: const Icon(Icons.connect_without_contact),
                          iconSize: 35,
                          color: Theme.of(context).primaryColor,
                          tooltip: 'Connect'),
                    ],
                  ),
                ]),
              ),
              const SizedBox(height: 20),
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Test Communication',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _sendMsgController,
                            decoration: const InputDecoration(
                                labelText: 'Send a message'),
                          ),
                        ),
                        IconButton(
                            onPressed: () => _sendMessage(),
                            icon: const Icon(Icons.mail),
                            iconSize: 35,
                            color: Theme.of(context).primaryColor,
                            tooltip: 'Send'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Consumer<WebSocketProvider>(
                      builder: (ctx, webSocket, _) =>
                          //Container(
                          //child:
                          InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Received Message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(webSocket.receivedMessage),
                      ),
                      // Text(webSocket.receivedMessage),
                    ),
                    //)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_sendMsgController.text.isNotEmpty) {
      RobotProvider.instance.WebSocket.updateSensors((_sendMsgController.text));
    }
  }

  void _connect() {
    print(_ipAddressController.text);
    print(_portController.text);
    if (_ipAddressController.text.isNotEmpty &&
        _portController.text.isNotEmpty) {
      RobotProvider.instance.WebSocket.ipAddress = _ipAddressController.text;
      RobotProvider.instance.WebSocket.port = _portController.text;
      RobotProvider.instance.WebSocket.Connect();
      //RobotProvider.instance.WebSocket.updateSensors((_sendMsgController.text));
    }

    @override
    void dispose() {
      _sendMsgController.dispose();
      _ipAddressController.dispose();
      _portController.dispose();
    }
  }
}

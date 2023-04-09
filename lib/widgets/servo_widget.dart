import 'package:flutter/material.dart';

class ServoWidget extends StatelessWidget {
  const ServoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print("Servo Widget Builder");
    return Scaffold(
        appBar: AppBar(
      title: const Text("Servo Motor Page"),
    ));
  }
}

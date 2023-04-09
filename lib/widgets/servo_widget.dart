import 'package:flutter/material.dart';
import 'package:robot_app/proviers/slider_provider.dart';
import 'package:robot_app/widgets/slider_widget.dart';
import 'package:provider/provider.dart';
import '../proviers/pid_provider.dart';
import '../proviers/servo_provider.dart';

const List<double> _servoLimits = <double>[0, 30, 60, 90, 120, 150, 180];

class ServoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //print("Pid Widget Builder");
    var servo = Provider.of<ServoProvider>(context, listen: false);
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: servo.servoSlider,
        child: SliderWidget(
          _servoLimits,
          servo.servoSlider.minVal,
          servo.servoSlider.maxVal,
        ),
      ),
    );
  }
}

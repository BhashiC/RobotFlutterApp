import 'package:flutter/material.dart';
import 'package:robot_app/proviers/slider_provider.dart';
import 'package:robot_app/widgets/slider_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';
import '../proviers/pid_provider.dart';

const List<double> _pidLimits = <double>[0, 0.1, 0.5, 1, 2, 5, 10, 20];

class PidWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //print("Pid Widget Builder");
    var pid = Provider.of<PidProvider>(context, listen: false);
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: pid.pidParameters.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: pid.pidParameters[i],
        child: SliderWidget(
          _pidLimits,
          pid.pidParameters[i].minVal,
          pid.pidParameters[i].maxVal,
        ),
      ),
    );
  }
}

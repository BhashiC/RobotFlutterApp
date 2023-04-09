import 'package:flutter/material.dart';
import '../proviers/slider_provider.dart';
import 'package:provider/provider.dart';

class SliderWidget extends StatelessWidget {
  final List<double> _limits;

  SliderWidget(this._limits, minLimit, maxLimit, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //print("Slider Widget Builder");
    var slider = Provider.of<SliderProvider>(context, listen: false);
    return Card(
        child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${slider.displayName} = ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Consumer<SliderProvider>(
            builder: (ctx, slider, _) =>
                Text(slider.currentVal.toStringAsFixed(2)),
          ),
        ],
      ),
      ListTile(
        leading: Consumer<SliderProvider>(
          builder: (ctx, slider, _) => DropdownButton(
            items: _limits.map<DropdownMenuItem<double>>((double value) {
              return DropdownMenuItem<double>(
                value: value,
                child: Text(value.toStringAsFixed(2)),
              );
            }).toList(),
            onChanged: (val) => slider.minVal = val as double,
            value: slider.minVal,
          ),
        ),
        title: Consumer<SliderProvider>(
          builder: (ctx, slider, _) => Slider(
            value: slider.currentVal,
            min: slider.minVal,
            max: slider.maxVal,
            divisions: 100,
            label: slider.currentVal.toStringAsFixed(2),
            onChanged: (val) => slider.currentVal = val,
          ),
        ),
        trailing: Consumer<SliderProvider>(
          builder: (ctx, slider, _) => DropdownButton(
            items: _limits.map<DropdownMenuItem<double>>((double value) {
              return DropdownMenuItem<double>(
                value: value,
                child: Text(value.toStringAsFixed(2)),
              );
            }).toList(),
            onChanged: (val) => slider.maxVal = val as double,
            value: slider.maxVal,
          ),
        ),
      ),
    ]));
  }
}

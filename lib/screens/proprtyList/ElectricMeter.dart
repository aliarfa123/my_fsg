import 'package:flutter/material.dart';
import 'package:my_fsg/theme/colors.dart';

class ElectricMeter extends StatefulWidget {
  ElectricMeter({Key? key}) : super(key: key);

  @override
  State<ElectricMeter> createState() => _ElectricMeterState();
}

class _ElectricMeterState extends State<ElectricMeter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: primary, title: Text('Electricity Meter')),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hello_flutter/core/res/styles/app_styles.dart';
import 'package:hello_flutter/models/greenhouse_repository.dart';
import 'package:hello_flutter/services/mqtt_service.dart';
import 'package:provider/provider.dart';

import '../../models/greenhouse.dart';

enum BandType{
  light,
  temperature,
  humidity,
}

class GreenhouseBand extends StatelessWidget {
  final BandType bandType;
  final String greenhouseId;

  const GreenhouseBand({super.key, required this.greenhouseId, required this.bandType});

  String get title {
    switch (bandType) {
      case BandType.light:
        return 'Luces';
      case BandType.temperature:
        return 'Temperatura';
      case BandType.humidity:
        return 'Humedad';
    }
  }

  Color bgColor() {
    switch (bandType) {
      case BandType.light:
        return Colors.amber;
      case BandType.temperature:
        return Colors.green;
      case BandType.humidity:
        return Colors.blue;
    }
  }

  Color insideColor() {
    switch (bandType) {
      case BandType.light:
        return Color (0xFFb59125);
      case BandType.humidity:
        return Colors.blue.shade900;
      case BandType.temperature:
        return Colors.green.shade900;
    }
  }

  Widget _buildContent(Greenhouse gh) {
    switch (bandType) {
      case BandType.temperature:
        return _temperatureRow(gh);
      case BandType.humidity:
        return _humidityRow(gh);
      case BandType.light:
        return Text("luces");
       // return _lightRow(gh);
    }
  }

  Widget _divider(){
    return const Divider();
  }

  Widget _valueBox(String value){
    return Container(
      child: Text(value, style: AppStyles.textLineStyle1),
    );
  }

  Widget _temperatureRow(Greenhouse gh){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _valueBox('${gh.temperature}°'),
        _divider(),
        Column(
          children: [
            Text("Max", style: AppStyles.textLineStyle3),
            _valueBox('${gh.tempMax}°'),
          ],
        ),
        _divider(),
        Column(
          children: [
            Text("Min", style: AppStyles.textLineStyle3),
            _valueBox('${gh.tempMax}°'),
          ],
        ),
      ],
    );
  }

  Widget _humidityRow(Greenhouse gh){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _valueBox('${gh.humidity}%'),
        _divider(),
        Column(
          children: [
            Text("Max", style: AppStyles.textLineStyle3),
            _valueBox('${gh.humidityMax}%'),
          ],
        ),
        _divider(),
        Column(
          children: [
            Text("Min", style: AppStyles.textLineStyle3),
            _valueBox('${gh.humidityMin}%'),
          ],
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final gh = context.watch<GreenhouseRepository>().getById(greenhouseId);
    final mqtt = context.read<MqttService>();

    return SizedBox(
      width: size.width * 0.85,
      height: 100,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: bgColor(),
          ),
          child: Column(
            children: [
              Text(title, style: AppStyles.textLineStyle2),
              Container(
                width: size.width * 0.85,
                height: 55,
                decoration: BoxDecoration(
                  color: insideColor(),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: _buildContent(gh!),
              )
            ],
          ),
        ),
      ),
    );
  }
}

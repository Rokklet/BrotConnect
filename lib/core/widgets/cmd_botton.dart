import 'package:flutter/material.dart';
import 'package:hello_flutter/core/res/styles/app_styles.dart';
import 'package:hello_flutter/models/greenhouse_repository.dart';
import 'package:hello_flutter/services/mqtt_service.dart';
import 'package:provider/provider.dart';

enum GreenhouseDevice {
  light,
  cooler,
}

class CmdBotton extends StatelessWidget {
  final GreenhouseDevice device;
  final String greenhouseId;

  const CmdBotton(
      {super.key, required this.device, required this.greenhouseId});

  String get title {
    switch (device) {
      case GreenhouseDevice.light:
        return 'Luces';
      case GreenhouseDevice.cooler:
        return 'Coolers';
    }
  }

  IconData get icon {
    switch (device) {
      case GreenhouseDevice.light:
        return Icons.power_settings_new;
      case GreenhouseDevice.cooler:
        return Icons.power_settings_new;
    }
  }

  Color bgColor() {
    switch (device) {
      case GreenhouseDevice.light:
        return Colors.amber;
      case GreenhouseDevice.cooler:
        return Colors.grey;
    }
  }

  Color activeColor() {
    switch (device) {
      case GreenhouseDevice.light:
        return Colors.amber.shade400;
      case GreenhouseDevice.cooler:
        return Colors.grey.shade400;
    }
  }

  Color inactiveColor() {
    switch (device) {
      case GreenhouseDevice.light:
        return Color (0xFFb59125);
      case GreenhouseDevice.cooler:
        return Colors.grey.shade800;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final gh = context.watch<GreenhouseRepository>().getById(greenhouseId);
    final mqtt = context.read<MqttService>();

    return SizedBox(
      width: size.width * 0.35,
      height: 120,
      child: InkWell(
        onTap: (){
          if(device == GreenhouseDevice.light){
            mqtt.publishLight(greenhouseId, !gh!.lightOn);
          }
        },
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: bgColor(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                child: Container(
                  width: size.width * 0.25,
                  height: 60,
                  decoration: BoxDecoration(
                    color: device == GreenhouseDevice.light ?
                    gh!.lightOn ? inactiveColor() : activeColor() :
                    gh!.coolerOn ? inactiveColor() : activeColor(),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(icon),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
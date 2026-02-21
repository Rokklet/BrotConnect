import 'package:flutter/material.dart';
import 'package:hello_flutter/core/res/styles/app_styles.dart';
import 'package:hello_flutter/core/widgets/cmd_botton.dart';
import 'package:hello_flutter/core/widgets/greenhouse_band.dart';
import 'package:hello_flutter/models/greenhouse_repository.dart';
import 'package:hello_flutter/services/mqtt_service.dart';
import 'package:provider/provider.dart';


class GreenhouseConfig extends StatefulWidget {
  const GreenhouseConfig({super.key});

  @override
  State<GreenhouseConfig> createState() => _GreenhouseConfigState();
}

class _GreenhouseConfigState extends State<GreenhouseConfig> {

  late double tempMin;
  late double tempMax;
  late double humidityMin;
  late double humidityMax;
  late int lightStartHour;
  late int lightEndHour;

  bool _initialized = false;

  void _saveConfig(String greenhouseId) {
    final mqtt = context.read<MqttService>();

    final config = {
      "tempMin": tempMin,
      "tempMax": tempMax,
      "humidityMin": humidityMin,
      "humidityMax": humidityMax,
      "lightStartHour": lightStartHour,
      "lightEndHour": lightEndHour,
    };

    print("tempMin: $tempMin");
    print("tempMax: $tempMax");
    print("humidityMin: $humidityMin");
    print("humidityMax: $humidityMax");
    print("lightStartHour: $lightStartHour");
    print("lightEndHour: $lightEndHour");


    mqtt.publishConfig(greenhouseId, config);
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    final greenhouseId =
    ModalRoute.of(context)!.settings.arguments as String;

    final gh = context.read<GreenhouseRepository>()
        .getById(greenhouseId);

    if (gh != null) {
      tempMin = gh.tempMin;
      tempMax = gh.tempMax;
      humidityMin = gh.humidityMin;
      humidityMax = gh.humidityMax;
      lightStartHour = gh.lightStartHour;
      lightEndHour = gh.lightEndHour;
    }

    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    final greenhouseId =
    ModalRoute.of(context)!.settings.arguments as String;


    return Scaffold(
      appBar: AppBar(
        title: Text("Control de Camara",
            textAlign: TextAlign.center,
            style: AppStyles.headLineStyle1),
      ),

      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(" $greenhouseId",
                    textAlign: TextAlign.center,
                    style: AppStyles.headLineStyle2),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  children: [
                    CmdBotton(device: GreenhouseDevice.light, greenhouseId: greenhouseId),
                    const SizedBox(width: 16),
                    CmdBotton(device: GreenhouseDevice.cooler, greenhouseId: greenhouseId)
                  ],
                ),
                const SizedBox(height: 16),
                Form(

                  child: SizedBox(
                    width: size.width * 0.90,
                    height: 400,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey.shade200
                      ),
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 10),

                        children: [
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GreenhouseBand(
                              greenhouseId: greenhouseId,
                              bandType: BandType.light,
                              onStartHourChanged: (value) {
                                setState(() => lightStartHour = value);
                              },
                              onEndHourChanged: (value) {
                                setState(() => lightEndHour = value);
                              },
                            ),
                          ),

                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GreenhouseBand(
                              greenhouseId: greenhouseId,
                              bandType: BandType.humidity,
                              onMinChanged: (value) {
                                setState(() => humidityMin = value);
                              },
                              onMaxChanged: (value) {
                                setState(() => humidityMax = value);
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GreenhouseBand(
                              greenhouseId: greenhouseId,
                              bandType: BandType.temperature,
                              onMinChanged: (value) {
                                setState(() => tempMin = value);
                              },
                              onMaxChanged: (value) {
                                setState(() => tempMax = value);
                              },
                            ),
                          ),

                        ],
                      ),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _saveConfig(greenhouseId);
                      },
                      child: const Text("Guardar"),
                    ),
                  ),
                )
              ],
            ),
          )
      )
    );
  }
}

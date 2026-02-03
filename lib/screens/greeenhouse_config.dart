import 'package:flutter/material.dart';
import 'package:hello_flutter/core/res/styles/app_styles.dart';
import 'package:hello_flutter/core/widgets/cmd_botton.dart';
import 'package:hello_flutter/core/widgets/greenhouse_band.dart';

class GreenhouseConfig extends StatelessWidget {

  const GreenhouseConfig({super.key});


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

      body: Column(
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
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    GreenhouseBand(greenhouseId: greenhouseId, bandType: BandType.light),
                    SizedBox(height: 10),
                    GreenhouseBand(greenhouseId: greenhouseId, bandType: BandType.humidity),
                    SizedBox(height: 10),
                    GreenhouseBand(greenhouseId: greenhouseId, bandType: BandType.temperature)
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hello_flutter/core/res/styles/app_styles.dart';
import 'package:hello_flutter/core/widgets/info_card_home.dart';
import 'package:hello_flutter/services/mqtt_service.dart';
import 'package:provider/provider.dart';

import '../../models/greenhouse_repository.dart';


class GreenhouseView extends StatelessWidget {
  final String greenhouseId;
  final bool wholeScreen;

  const GreenhouseView({super.key, required this.greenhouseId, this.wholeScreen=false});


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final gh = context.watch<GreenhouseRepository>().getById(greenhouseId);


    return SizedBox(
      width: size.width * 0.85,
      height: 179,
      child: InkWell(
        onTap:() => Navigator.pushNamed(context,"greenhouse_config",arguments: greenhouseId),
        child: Container(
          decoration: BoxDecoration(
            color: AppStyles.greenhouseColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(21),
                topRight: Radius.circular(21),
                bottomLeft:Radius.circular(21),
                bottomRight: Radius.circular(21)
            ),
          ),
          margin: EdgeInsets.only(right: wholeScreen==true?0:16),
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${gh?.name}',
                    style: AppStyles.headLineStyle3.copyWith(color: Colors.white),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: gh!.lightOn ? Colors.amber : Colors.grey,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    width: 35,
                    height: 35,
                    child: Icon(Icons.lightbulb_outline,color: gh!.lightOn ? Colors.white : Colors.black,),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InfoCard(
                      title: "Humedad",
                      value: "${gh?.humidity} %",
                      max: "${gh?.humidityMax} %",
                      min: "${gh?.humidityMin} %",
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 16),
                    InfoCard(
                      title: "Temperatura",
                      value: "${gh?.temperature} °C",
                      max: "${gh?.tempMax} °",
                      min: "${gh?.tempMin} °",
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

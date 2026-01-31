import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/core/res/media.dart';
import 'package:hello_flutter/core/res/styles/app_styles.dart';
import 'package:hello_flutter/core/widgets/app_doble_text.dart';
import 'package:hello_flutter/core/widgets/app_lateral_scroll.dart';
import 'package:hello_flutter/core/widgets/greenhouse_view.dart';
import 'package:hello_flutter/models/greenhouse_repository.dart';
import 'package:hello_flutter/services/mqtt_service.dart';
import 'package:provider/provider.dart';




class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final greenhouses = context.watch<GreenhouseRepository>().getAll();

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body:ListView(
        children: [
          SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bienvenido",
                        style: AppStyles.headLineStyle3),
                      const SizedBox(height: 5,),
                      Text("Tus Cultivos",
                        style: AppStyles.headLineStyle1)
                    ],
                  ),

                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: AssetImage(AppMedia.logo)
                      )
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25),
              AppDoubleText(bigText: "Activos", smallText: "ver todos"),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: greenhouses
                      .map((gh) => GreenhouseView(greenhouseId: gh.id))
                      .toList(),
                ),
              )
            ],
          )),

        ],
      )
    );
  }
}

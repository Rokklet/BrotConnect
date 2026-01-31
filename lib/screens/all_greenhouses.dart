import 'package:flutter/material.dart';
import 'package:hello_flutter/core/res/styles/app_styles.dart';
import 'package:hello_flutter/core/widgets/greenhouse_view.dart';
import 'package:hello_flutter/models/greenhouse_repository.dart';
import 'package:provider/provider.dart';

class AllGreenhouses extends StatelessWidget {
  const AllGreenhouses({super.key});

  @override
  Widget build(BuildContext context) {

    final greenhouses = context.watch<GreenhouseRepository>().getAll();

    return Scaffold(
      appBar: AppBar(
        title: Text("Tus Cultivos Activos",
            style: AppStyles.headLineStyle1),
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Column(
              children: greenhouses
                        .map((gh) => Container(
                          margin: EdgeInsets.only(bottom: 20),
                          alignment: Alignment.center,
                          child: GreenhouseView(greenhouseId: gh.id, wholeScreen: true,)),
              )
                        .toList(),
            ),
          )
        ],
      ),
    );
  }
}

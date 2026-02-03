import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/models/greenhouse_repository.dart';
import 'package:hello_flutter/pages/login.dart';
import 'package:hello_flutter/screens/all_greenhouses.dart';
import 'package:hello_flutter/screens/greeenhouse_config.dart';
import 'package:hello_flutter/services/mqtt_service.dart';
import 'core/bottom_nav_bar.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => GreenhouseRepository()),
          ChangeNotifierProvider(
            create: (context) =>
                MqttService(context.read<GreenhouseRepository>()),
            ),
        ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'BrotControl',

      debugShowCheckedModeBanner: false,

      home: const BottomNavBar(),

      routes: {
        "all_greenhouses" : (context) => const AllGreenhouses(),
        "greenhouse_config" : (context) => const GreenhouseConfig(),
      },
    );
  }
}


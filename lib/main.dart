import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/login.dart';

import 'core/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'BrotControl',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff7ed957)),
      ),

      home: BottomNavBar(),
    );
  }
}


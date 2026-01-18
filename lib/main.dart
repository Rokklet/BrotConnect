import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/pages/login.dart';

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
      home: const MyHomePage(title: 'BrotControl'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title}); 
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //Scri
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text(
              widget.title,
              style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontFamily: "Chau Philomone",
              ),
            ),
        )
      ),
      body: LoginPage(
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
import 'package:example/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/flutter_start.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const FlutterStart(),
    );
  }
}

class FlutterStart extends StatelessWidget {
  const FlutterStart({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterStartNavigatorUserstory(
      startService: StartService(),
      options: const FlutterStartOptions(),
      afterIntroduction: (context) async {
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const AfterIntroduction(),
          ),
        );
      },
    );
  }
}

class AfterIntroduction extends StatelessWidget {
  const AfterIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("After Introduction"),
      ),
      body: const Center(
        child: Text("After Introduction"),
      ),
    );
  }
}

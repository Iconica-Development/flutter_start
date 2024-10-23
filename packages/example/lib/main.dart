import 'package:flutter/material.dart';
import 'package:flutter_start/flutter_start.dart';

import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: Home(),
      );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) => NavigatorStartUserStory(
        // configuration: config,
        onComplete: (context) async {
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeEntry()),
          );
        },
      );
}

StartUserStoryConfiguration config = StartUserStoryConfiguration(
  // showIntroduction: false,
  introductionService: MyIntroductionService(),
  splashScreenBuilder: (context, onFinish) => SplashScreen(
    onFinish: onFinish,
  ),
);

class MyIntroductionService implements IntroductionService {
  @override
  Future<void> onComplete() {
    // TODO: implement onComplete
    throw UnimplementedError();
  }

  @override
  Future<void> onSkip() {
    // TODO: implement onSkip
    throw UnimplementedError();
  }

  @override
  Future<bool> shouldShow() {
    // TODO: implement shouldShow
    throw UnimplementedError();
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    required this.onFinish,
    super.key,
  });

  final Function() onFinish;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      widget.onFinish();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('SplashScreen'),
        ),
        body: const Center(child: Text('SplashScreen')),
      );
}

class HomeEntry extends StatelessWidget {
  const HomeEntry({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('HomeEntry'),
        ),
        body: const Center(child: Text('HomeEntry')),
      );
}

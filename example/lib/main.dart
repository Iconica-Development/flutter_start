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
  Widget build(BuildContext context) => startNavigatorUserStory(
        context,
        config,
        onComplete: (context) async {
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeEntry()),
          );
        },
      );
}

List<GoRoute> getStartRoutes() => getStartStoryRoutes(
      config,
    );

StartUserStoryConfiguration config = StartUserStoryConfiguration(
  // showIntroduction: false,
  splashScreenBuilder: (context, onFinish) => SplashScreen(
    onFinish: onFinish,
  ),
  introductionOptionsBuilder: (ctx) => IntroductionOptions(
    pages: [
      IntroductionPage(
        title: const Text('First page'),
        text: const Text('Wow a page'),
        graphic: const FlutterLogo(),
      ),
      IntroductionPage(
        title: const Text('Second page'),
        text: const Text('Another page'),
        graphic: const FlutterLogo(),
      ),
      IntroductionPage(
        title: const Text('Third page'),
        text: const Text('The final page of this app'),
        graphic: const FlutterLogo(),
      ),
    ],
    introductionTranslations: const IntroductionTranslations(
      skipButton: 'Skip it!',
      nextButton: 'Next',
      previousButton: 'Previous',
      finishButton: 'To the app!',
    ),
    tapEnabled: true,
    displayMode: IntroductionDisplayMode.multiPageHorizontal,
    buttonMode: IntroductionScreenButtonMode.text,
    indicatorMode: IndicatorMode.dash,
    skippable: true,
    buttonBuilder: (context, onPressed, child, type) =>
        ElevatedButton(onPressed: onPressed, child: child),
  ),
);

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

class ExampleIntroductionDataProvider
    implements SharedPreferencesIntroductionDataProvider {
  @override
  String key = 'example';

  @override
  Future<void> setCompleted({bool value = true}) async =>
      // ignore: void_checks
      false;

  @override
  Future<bool> shouldShow() async => true;
}

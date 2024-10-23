import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_start/flutter_start.dart";

/// A splash screen that is shown when the app is started.
class SplashScreen extends StatefulWidget {
  /// SplashScreen constructor.
  const SplashScreen({
    required this.afterSplashScreen,
    required this.startService,
    required this.options,
    super.key,
  });

  /// The options to configure the splash screen.
  final FlutterStartOptions options;

  /// The function that is executed after the splash screen.
  final Function(BuildContext context) afterSplashScreen;

  /// The start service to start the Flutter app.
  final StartService startService;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool minimumDurationPassed = false;
  bool futureCompleted = false;
  bool canContinue = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(
        Duration(seconds: widget.options.minimumSplashScreenDuration.toInt()),
        () {
      setState(() {
        minimumDurationPassed = true;
      });
      checkTransitionConditions();
    });

    if (widget.options.splashScreenFuture != null) {
      unawaited(
        widget.options.splashScreenFuture!(context).then((_) {
          setState(() {
            futureCompleted = true;
          });
          checkTransitionConditions();
        }),
      );
    } else {
      futureCompleted = true;
    }

    if (widget.options.iskillswitchEnabled) {
      unawaited(
        widget.startService.isKillswitchActive().then((value) {
          setState(() {
            canContinue = !value;
          });
          checkTransitionConditions();
        }),
      );
    } else {
      canContinue = true;
    }
  }

  void checkTransitionConditions() {
    if (minimumDurationPassed &&
        futureCompleted &&
        canContinue &&
        context.mounted) {
      widget.afterSplashScreen(context);
    }
  }

  @override
  Widget build(BuildContext context) =>
      widget.options.splashScreenBuilder?.call(context) ??
      Scaffold(
        backgroundColor: widget.options.splashScreenBackgroundColor,
        body: Center(
          child: widget.options.splashScreenCenterWidget ??
              Text(
                "iconinstagram",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
        ),
      );
}

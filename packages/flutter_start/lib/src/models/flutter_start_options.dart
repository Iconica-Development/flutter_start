import "package:flutter/material.dart";
import "package:flutter_introduction/flutter_introduction.dart";

/// Options to configure the start of the Flutter app.
class FlutterStartOptions {
  /// FlutterStartOptions constructor.

  const FlutterStartOptions({
    this.splashScreenBackgroundColor = const Color(0xff212121),
    this.introductionOptions = const IntroductionOptions(),
    this.minimumSplashScreenDuration = 3,
    this.canPopFromIntroduction = true,
    this.introDuctionFallBackScreen,
    this.iskillswitchEnabled = true,
    this.introductionScrollPhysics,
    this.splashScreenCenterWidget,
    this.useSplashScreen = true,
    this.splashScreenBuilder,
    this.introductionService,
    this.splashScreenFuture,
    this.afterSplashScreen,
    this.afterIntroduction,
  });

  /// The background color of the splash screen.
  final Color splashScreenBackgroundColor;

  /// The center widget of the splash screen.
  final Widget? splashScreenCenterWidget;

  /// If the splash screen should be used.
  final bool useSplashScreen;

  /// The minimum duration of the splash screen.
  final double minimumSplashScreenDuration;

  /// The future that is executed when the splash screen is shown.
  final Future<void> Function(BuildContext context)? splashScreenFuture;

  /// The builder of the splash screen.
  final Widget Function(BuildContext context)? splashScreenBuilder;

  /// The function that is executed after the introduction screen.
  final IntroductionOptions introductionOptions;

  /// The introduction options to configure the introduction screen.
  final IntroductionService? introductionService;

  /// The scroll physics of the introduction screen.
  final ScrollPhysics? introductionScrollPhysics;

  /// The fallback screen of the introduction screen.
  final Widget? introDuctionFallBackScreen;

  /// The function that is executed after the splash screen.
  final Function(BuildContext context)? afterSplashScreen;

  /// The function that is executed after the introduction screen.
  final Function(BuildContext context)? afterIntroduction;

  /// Whether or not the Introduction can be popped.
  final bool canPopFromIntroduction;

  /// Whether or not the killswitch is enabled.
  final bool iskillswitchEnabled;
}

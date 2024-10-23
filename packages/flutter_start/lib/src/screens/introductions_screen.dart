import "package:flutter/material.dart";
import "package:flutter_start/flutter_start.dart";

/// The introduction screen of the Flutter app.
class IntroductionsScreen extends StatelessWidget {
  /// IntrdoctionScreen constructor
  const IntroductionsScreen({
    required this.introDuctionFallBackScreen,
    required this.introductionScrollPhysics,
    required this.introductionOptions,
    required this.introductionService,
    required this.afterIntroduction,
    required this.options,
    super.key,
  });

  /// The function that is executed after the introduction screen.
  final Function() afterIntroduction;

  /// The options to configure the introduction screen.
  final IntroductionOptions introductionOptions;

  /// The introduction service to configure the introduction screen.
  final IntroductionService introductionService;

  /// The scroll physics of the introduction screen.
  final ScrollPhysics? introductionScrollPhysics;

  /// The fallback screen of the introduction screen.
  final Widget? introDuctionFallBackScreen;

  /// The options to configure the start of the Flutter app.
  final FlutterStartOptions options;

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: options.canPopFromIntroduction,
        child: Introduction(
          options: introductionOptions,
          navigateTo: afterIntroduction,
          physics: introductionScrollPhysics,
          service: introductionService,
          child: introDuctionFallBackScreen,
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_introduction/flutter_introduction.dart';

@immutable
class StartUserStoryConfiguration {
  const StartUserStoryConfiguration({
    this.splashScreenBuilder,
    this.introductionOptions = const IntroductionOptions(),
    this.introductionService,
    this.homeEntry,
    this.introductionFallbackScreen,
    this.introductionScrollPhysics,
    this.showIntroduction = true,
    this.useKillswitch = false,
  });
  final Widget Function(
    BuildContext context,
    Function() onFinish,
  )? splashScreenBuilder;

  final Widget? homeEntry;

  final IntroductionOptions introductionOptions;
  final Widget? introductionFallbackScreen;
  final IntroductionService? introductionService;
  final ScrollPhysics? introductionScrollPhysics;
  final bool? showIntroduction;
  final bool? useKillswitch;
}

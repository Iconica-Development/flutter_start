import 'package:flutter/material.dart';
import 'package:flutter_introduction/flutter_introduction.dart';

/// An immutable class that represents the configuration for
/// starting a user story.
@immutable
class StartUserStoryConfiguration {
  /// Creates a new instance of [StartUserStoryConfiguration].
  const StartUserStoryConfiguration({
    this.splashScreenBuilder,
    this.introductionBuilder,
    this.introductionOptionsBuilder,
    this.introductionService,
    this.homeEntry,
    this.homeScreenRoute,
    this.introductionFallbackScreen,
    this.introductionScrollPhysics,
    this.showIntroduction = true,
    this.useKillswitch = false,
    this.minimumSplashScreenDuration = 3,
    this.splashScreenFuture,
    this.splashScreenCenterWidget,
    this.splashScreenBackgroundColor,
  });

  /// You can use this to build your own splash screen.
  final Widget Function(
    BuildContext context,
    Function() onFinish,
  )? splashScreenBuilder;

  /// This is used to wrap the introduction widget in your own custom page.
  final Widget Function(
    BuildContext context,
    Widget introductionPage,
  )? introductionBuilder;

  /// The route that is used to navigate to the home screen.
  final String? homeScreenRoute;

  final Widget? homeEntry;

  final IntroductionOptions Function(BuildContext context)?
      introductionOptionsBuilder;
  final Widget? introductionFallbackScreen;
  final IntroductionService? introductionService;
  final ScrollPhysics? introductionScrollPhysics;

  /// If the introduction should be shown.
  final bool showIntroduction;

  /// If the killswitch is enabled this app can be remotely disabled.
  final bool useKillswitch;

  /// The widget that is shown in the center of the splash screen.
  final WidgetBuilder? splashScreenCenterWidget;

  /// The background color of the splash screen.
  final Color? splashScreenBackgroundColor;

  /// The minimum duration the splash screen in seconds.
  final int minimumSplashScreenDuration;

  /// The future that is awaited before the splash screen is closed.
  final Future<String?> Function(BuildContext context)? splashScreenFuture;
}

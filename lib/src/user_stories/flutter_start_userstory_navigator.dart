import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_start/flutter_start.dart';
import 'package:flutter_start/src/services/killswitch_service.dart';
import 'package:flutter_start/src/widgets/default_splash_screen.dart';

/// Initial screen of the user story.
///
/// Use this when defining an initial route.
class NavigatorStartUserStory extends StatelessWidget {
  const NavigatorStartUserStory({
    required this.onComplete,
    this.configuration = const StartUserStoryConfiguration(),
    super.key,
  });

  final StartUserStoryConfiguration configuration;
  final void Function(BuildContext context) onComplete;

  @override
  Widget build(BuildContext context) => Navigator(
        onGenerateInitialRoutes: (_, __) => [
          _getInitialRoute(configuration, onComplete),
        ],
      );
}

/// Enter the start user story with the Navigator 1.0 API.
///
/// Requires a Navigator widget to exist in the given [context].
///
/// Customization can be done through the [configuration] parameter.
///
/// [onComplete] triggers as soon as the userstory is finished.
///
/// The context provided here is a context has a guaranteed navigator.
Future<void> startNavigatorUserStory(
  BuildContext context,
  StartUserStoryConfiguration configuration, {
  required void Function(BuildContext context) onComplete,
}) async {
  var initialRoute = _getInitialRoute(configuration, onComplete);

  await Navigator.of(context).push(initialRoute);
}

MaterialPageRoute<dynamic> _getInitialRoute(
  StartUserStoryConfiguration configuration,
  void Function(BuildContext context) onComplete,
) {
  var initialRoute = MaterialPageRoute(
    builder: (context) => _splashScreen(
      configuration,
      context,
      onComplete,
    ),
  );

  if (!configuration.showSplashScreen && configuration.showIntroduction) {
    initialRoute = MaterialPageRoute(
      builder: (context) => _introduction(
        configuration,
        context,
        onComplete,
      ),
    );
  }
  return initialRoute;
}

Widget _splashScreen(
  StartUserStoryConfiguration configuration,
  BuildContext context,
  void Function(BuildContext context) onComplete,
) {
  var navigator = Navigator.of(context);

  var isAllowedToPassThrough = false;

  Future<void> splashHandler() async {
    await Future.wait<void>(
      [
        configuration.splashScreenFuture?.call(context) ?? Future.value(),
        Future.delayed(
          Duration.zero,
          () async {
            if (configuration.useKillswitch) {
              var killswitchService =
                  configuration.killswitchService ?? DefaultKillswitchService();

              isAllowedToPassThrough =
                  await killswitchService.isKillswitchActive();
            }
          },
        ),
        Future.delayed(
          Duration(
            seconds: configuration.minimumSplashScreenDuration,
          ),
        ),
      ],
    );

    if (configuration.useKillswitch && isAllowedToPassThrough) return;

    var introService = configuration.introductionService ??
        IntroductionService(SharedPreferencesIntroductionDataProvider());

    var shouldShowIntroduction =
        configuration.showIntroduction && await introService.shouldShow();

    if (!context.mounted) return;

    if (!shouldShowIntroduction) return onComplete(context);

    await navigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => _introduction(
          configuration,
          context,
          onComplete,
        ),
      ),
    );
  }

  unawaited(splashHandler());

  var builder = configuration.splashScreenBuilder;

  if (builder == null) {
    return Scaffold(
      backgroundColor: configuration.splashScreenBackgroundColor,
      body: Center(
        child: configuration.splashScreenCenterWidget?.call(context) ??
            defaultSplashScreen(context),
      ),
    );
  }

  return builder.call(
    context,
    splashHandler,
  );
}

Widget _introduction(
  StartUserStoryConfiguration configuration,
  BuildContext context,
  void Function(BuildContext context) onComplete,
) {
  var introduction = Introduction(
    service: configuration.introductionService ??
        IntroductionService(SharedPreferencesIntroductionDataProvider()),
    navigateTo: () async => onComplete(context),
    options: configuration.introductionOptionsBuilder?.call(context) ??
        const IntroductionOptions(),
    physics: configuration.introductionScrollPhysics,
    child: configuration.introductionFallbackScreen,
  );
  return PopScope(
    canPop: configuration.canPopFromIntroduction,
    child: configuration.introductionBuilder?.call(
          context,
          introduction,
        ) ??
        Scaffold(
          body: introduction,
        ),
  );
}

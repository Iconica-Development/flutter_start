import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_start/flutter_start.dart';
import 'package:flutter_start/src/services/killswitch_service.dart';

Widget startNavigatorUserStory(
  StartUserStoryConfiguration configuration,
  BuildContext context,
) {
  if (configuration.splashScreenBuilder == null &&
      configuration.splashScreenCenterWidget == null &&
      configuration.splashScreenBackgroundColor == null) {
    return _introduction(configuration, context);
  }
  return _splashScreen(configuration, context);
}

Widget _splashScreen(
  StartUserStoryConfiguration configuration,
  BuildContext context,
) {
  var navigator = Navigator.of(context);

  var isAllowedToPassThrough = false;
  var introductionSeen = false;

  Future<void> splashHandler() async {
    await Future.wait<void>(
      [
        configuration.splashScreenFuture?.call(context) ?? Future.value(),
        Future.delayed(
          Duration.zero,
          () async {
            if (configuration.useKillswitch)
              isAllowedToPassThrough =
                  await KillswitchService().isKillswitchActive();
            var introService = configuration.introductionService ??
                IntroductionService(
                  SharedPreferencesIntroductionDataProvider(),
                );
            introductionSeen = !await introService.shouldShow();
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

    if ((!configuration.showIntroduction || introductionSeen) &&
        context.mounted) {
      await navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => _home(configuration, context),
        ),
      );
    }

    if (context.mounted) {
      await navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => _introduction(configuration, context),
        ),
      );
    }
  }

  var builder = configuration.splashScreenBuilder;

  if (builder == null) {
    unawaited(splashHandler());
    return Scaffold(
      backgroundColor: configuration.splashScreenBackgroundColor,
      body: Center(
        child: configuration.splashScreenCenterWidget?.call(context) ??
            const SizedBox.shrink(),
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
) {
  var introduction = Introduction(
    service: configuration.introductionService ??
        IntroductionService(SharedPreferencesIntroductionDataProvider()),
    navigateTo: () async => Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => _home(configuration, context),
      ),
    ),
    options: configuration.introductionOptionsBuilder?.call(context) ??
        const IntroductionOptions(),
    physics: configuration.introductionScrollPhysics,
    child: configuration.introductionFallbackScreen,
  );
  return PopScope(
    canPop: configuration.canPopFromIntroduction,
    child: Scaffold(
      body: introduction,
    ),
  );
}

Widget _home(
  StartUserStoryConfiguration configuration,
  BuildContext context,
) {
  var home = configuration.homeEntry;
  return Scaffold(
    body: home,
  );
}

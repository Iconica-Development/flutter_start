import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_start/flutter_start.dart';
import 'package:flutter_start/src/services/killswitch_service.dart';

/// Enter the start user story with the Navigator 1.0 API.
///
/// Requires a Navigator widget to exist in the given [context].
///
/// Customization can be done through the [configuration] parameter.
///
/// [onComplete] triggers as soon as the userstory is finished.
///
/// The context provided here is a context has a guaranteed navigator.
Widget startNavigatorUserStory(
  BuildContext context,
  StartUserStoryConfiguration configuration, {
  required void Function(BuildContext context) onComplete,
}) {
  if (configuration.splashScreenBuilder == null &&
      configuration.splashScreenCenterWidget == null &&
      configuration.splashScreenBackgroundColor == null) {
    return _introduction(configuration, context, onComplete);
  }
  return _splashScreen(configuration, context, onComplete);
}

Widget _splashScreen(
  StartUserStoryConfiguration configuration,
  BuildContext context,
  void Function(BuildContext context) onComplete,
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
            if (configuration.useKillswitch) {
              var killswitchService =
                  configuration.killswitchService ?? DefaultKillswitchService();

              isAllowedToPassThrough =
                  await killswitchService.isKillswitchActive();
            }

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
      onComplete(context);
      return;
    }

    if (context.mounted) {
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
    child: Scaffold(
      body: introduction,
    ),
  );
}

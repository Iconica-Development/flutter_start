import 'package:flutter/material.dart';
import 'package:flutter_introduction_shared_preferences/flutter_introduction_shared_preferences.dart';
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
  var killSwitchIsActive = false;
  Future<void> myFunction() async {
    await Future.wait<void>(
      [
        configuration.splashScreenFuture?.call(context) ?? Future.value(),
        Future.delayed(
          Duration.zero,
          () async {
            if (configuration.useKillswitch)
              killSwitchIsActive =
                  await KillswitchService().isKillswitchActive();
          },
        ),
        Future.delayed(
          Duration(
            seconds: configuration.minimumSplashScreenDuration,
          ),
          () async {},
        ),
      ],
    );

    if (configuration.useKillswitch) {
      if (!killSwitchIsActive) {
        return;
      }
    }
    if (!configuration.showIntroduction) {
      await navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => _home(configuration, context),
        ),
      );
    }
    await navigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => _introduction(configuration, context),
      ),
    );
  }

  return configuration.splashScreenBuilder?.call(
        context,
        () async => myFunction(),
      ) ??
      Scaffold(
        backgroundColor: configuration.splashScreenBackgroundColor,
        body: Center(
          child: configuration.splashScreenCenterWidget?.call(context) ??
              const SizedBox.shrink(),
        ),
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
  return Scaffold(
    body: introduction,
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

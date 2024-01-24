import 'package:flutter/material.dart';
import 'package:flutter_introduction_shared_preferences/flutter_introduction_shared_preferences.dart';
import 'package:flutter_start/flutter_start.dart';

Widget startNavigatorUserStory(
    StartUserStoryConfiguration configuration, BuildContext context) {
  if (configuration.splashScreenBuilder == null) {
    return _introduction(configuration, context);
  }
  return _splashScreen(configuration, context);
}

Widget _splashScreen(
  StartUserStoryConfiguration configuration,
  BuildContext context,
) {
  return configuration.splashScreenBuilder?.call(
        context,
        () {
          if (configuration.showIntroduction == false) {
            return Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => _home(configuration, context),
              ),
            );
          }
          return Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => _introduction(configuration, context),
            ),
          );
        },
      ) ??
      const Scaffold(
        body: SizedBox.shrink(),
      );
}

Widget _introduction(
  StartUserStoryConfiguration configuration,
  BuildContext context,
) {
  var introduction = Introduction(
    service: configuration.introductionService ??
        IntroductionService(SharedPreferencesIntroductionDataProvider()),
    navigateTo: () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => _home(configuration, context),
        ),
      );
    },
    options: configuration.introductionOptions,
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

import "package:flutter/material.dart";
import "package:flutter_introduction_shared_preferences/flutter_introduction_shared_preferences.dart";
import "package:flutter_start/flutter_start.dart";

/// A userstory that navigates to the start of the Flutter app.
class FlutterStartNavigatorUserstory extends StatelessWidget {
  /// FlutterStartNavigatorUserstory constructor.
  FlutterStartNavigatorUserstory({
    required this.afterIntroduction,
    this.options = const FlutterStartOptions(),
    StartService? startService,
    super.key,
  }) : startService = startService ?? StartService();

  /// The start service to start the Flutter app.
  final StartService startService;

  /// The options to configure the start of the Flutter app.
  final FlutterStartOptions options;

  /// The function that is executed after the introduction screen.
  final Function(BuildContext context) afterIntroduction;

  @override
  Widget build(BuildContext context) =>
      options.useSplashScreen ? splashScreen() : introductionScreen(context);

  /// The splash screen of the Flutter app.
  Widget splashScreen() => SplashScreen(
        options: options,
        startService: startService,
        afterSplashScreen: (ctx) async {
          options.afterSplashScreen?.call(ctx) ??
              await Navigator.of(ctx).pushReplacement(
                MaterialPageRoute(
                  builder: introductionScreen,
                ),
              );
        },
      );

  /// The introduction screen of the Flutter app.
  Widget introductionScreen(BuildContext context) => IntroductionsScreen(
        options: options,
        introductionOptions: options.introductionOptions,
        afterIntroduction: () async => afterIntroduction.call(context),
        introductionService: options.introductionService ??
            IntroductionService(SharedPreferencesIntroductionDataProvider()),
        introductionScrollPhysics: options.introductionScrollPhysics,
        introDuctionFallBackScreen: options.introDuctionFallBackScreen,
      );
}

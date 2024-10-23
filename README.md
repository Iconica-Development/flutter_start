# flutter_start

Flutter_start is a package that allows you to jumpstart your application with a splashScreen, introduction and a home.

## Setup

To use flutter_start in your flutter app, import it in your pubspec.yaml:

``` yaml
  flutter_chat:
    git:
      url: https://github.com/Iconica-Development/flutter_start
      path: packages/flutter_start
      ref: 5.0.0
```

After importing flutter_start you can add the `FlutterStartNavigatorUserstory` widget like so:

``` dart
class FlutterStart extends StatelessWidget {
  const FlutterStart({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterStartNavigatorUserstory(
      startService: StartService(),
      options: const FlutterStartOptions(),
      afterIntroduction: (context) async {},
    );
  }
}
```

startService: optional, Used for adding a killswitch implementation to the app. This is a function that will be called before exiting the splash screen. If the function returns false, it will continue to the introductions. otherwise it will go no further.

options: optional, here you can tweek some settings of flutter_start to your liking.

afterIntroduction: required, after showing the introduction, this function will be called. Here you can navigate to the home screen or any other screen you want to show after the introduction. If you do not want introductions you can use the `afterSplashScreen` function in the `FlutterStartOptions` to navigate to the home screen.

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_start) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute
If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_start/pulls).

## Author
flutter_start for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>
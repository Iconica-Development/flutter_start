# flutter_start

Flutter_start is a package that allows you to jumpstart your application with a splashScreen, introduction and a home.

## Setup

To use this package, add flutter_start as a dependency in your pubspec.yaml file:

```
  flutter_start:
    git:
      url: https://github.com/Iconica-Development/flutter_start
      ref: <Version>
```

To use the module within your Flutter-application with predefined `Go_router` routes you should add the following:

Add go_router as dependency to your project.
Add the following configuration to your flutter_application:

```
StartUserStoryConfiguration startUserStoryConfiguration = const StartUserStoryConfiguration();
```

and set the values as you wish.

Next add the `StartUserStoryConfiguration` to `getStartStoryRoutes` Like so:

```
List<GoRoute> getStartRoutes() => getStartStoryRoutes(
      startUserStoryConfiguration,
    );
```

Finally add the `getStartRoutes` to your `Go_router` routes like so:

```
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    ...getStartRoutes()
  ],
);
```

The routes that can be used to navigate are:

For routing to the `SplashScreen`:

```
  static const String splashScreen = '/splashScreen';
```

For routing to the `Introduction`:

```
  static const String introduction = '/introduction';
```

For routing to the `HomeEntry`:

```
  static const String home = '/home';
```

If you don't want a SplashScreen in your application set your initialRoute to `Introduction`:

```
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    ...getStartRoutes()
  ],
    initialLocation: '/introduction',
);
```

To use the module within your Flutter-application without predefined `Go_router` routes but with `Navigator` routes add the following :

Add the following configuration to your flutter_application:

```
StartUserStoryConfiguration startUserStoryConfiguration = const StartUserStoryConfiguration();
```

Add the following code to the build-method of a chosen widget:

```
startNavigatorUserStory(startUserStoryConfiguration, context);
```

If the splashScreenBuilder is not used the SplashScreen will be skipped.

The `StartUserStoryConfiguration` has its own parameters, as specified below:
| Parameter | Explanation |
|-----------|-------------|
| splashScreenBuilder | The builder for the splashScreen. |
| introductionOptions | The options for the introduction. |
| introductionService | The service for the introduction. Default IntroductionService (SharedPreferencesIntroductionDataProvider()) |
| homeEntry | The widget that will be shown after the introduction. |
| introductionFallbackScreen | The widget that will be shown when the introduction is skipped. |
| introductionScrollPhysics | The scrollPhysics for the introduction. |
| showIntroduction | Whether or not the introduction should be shown. |
| useKillswitch | Whether or not the killswitch should be used. This will only work when you use the splashScreen and you need to have a active internet connection|

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_start) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute
[text](about:blank#blocked)
If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_start/pulls).

## Author

This flutter_start for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>
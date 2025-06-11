# flutter_start

Flutter_start is a package that allows you to jumpstart your application with a splashScreen, introduction and a home.

## Setup

To use this package, add flutter_start as a dependency in your pubspec.yaml file:

```yaml
dependencies:
  flutter_start: 
    hosted: https://forgejo.internal.iconica.nl/api/packages/internal/pub
    version: <current version>
```

## go_router

Add `go_router` as dependency to your project.

Add the following configuration to your flutter_application:

```
List<GoRoute> getStartStoryRoutes() => getStartStoryRoutes();
```

Or with options:

Place the following code somewhere in your project where it can be accessed globally:

```
var startUserStoryConfiguration = const StartUserStoryConfiguration();
```

```
List<GoRoute> getStartStoryRoutes() => getStartStoryRoutes(
      configuration: startUserStoryConfiguration,
    );
```

Finally add the `getStartRoutes` to your `go_router` routes like so:

```
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    ...getStartStoryRoutes()
  ],
);
```

The routes that can be used to navigate are:

For routing to the `splashScreen`:

```
static const String splashScreen = '/splashScreen';
```

For routing to the `introduction`:

```
static const String introduction = '/introduction';
```

For routing to the `home`:

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

## Navigator

Add the following code to the build-method of a chosen widget like so:
```
class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigatorStartUserStory(
      onComplete: (context) {},
    );
  }
}
```

or with options:

Place the following code somewhere in your project where it can be accessed globally:

```
var startUserStoryConfiguration = const StartUserStoryConfiguration();
```

```
class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigatorStartUserStory(
      configuration: startUserStoryConfiguration,
      onComplete: (context) {},
    );
  }
}
```

The `StartUserStoryConfiguration` has its own parameters, as specified below:
| Parameter | Explanation |
|-----------|-------------|
| `splashScreenBuilder` | The builder to override the default splashScreen |
| `introductionBuilder` | A builder to wrap the introductions in your own page |
| `introductionOptionsBuilder` | The builder to override the default `introductionOptions` |
|`introductionService` | The service to override the default `introductionService` |
| `homeScreenRoute` | The route to navigate to after the introduction or splashScreen is completed |
| `introductionFallbackScreen` | The screen that is shown when something goes wrong fetching data for the introduction |
| `introductionScrollPhysics` | The scroll physics for the introduction |
| `showIntroduction` | A boolean to show the introduction or not. Defaults to true |
| `useKillswitch` | A boolean to use the killswitch or not. Defaults to false |
| `minimumSplashScreenDuration` | The minimum duration the splashScreen should be shown. Defaults to 3 seconds |
| `splashScreenFuture` | The future to be completed before the splashScreen is completed |
| `splashScreenCenterWidget` | The widget to be shown in the center of the splashScreen |
| `splashScreenBackgroundColor` | The color of the splashScreen background. Defaults to ThemeData.scaffoldBackgroundColor |
| `canPopFromIntroduction` | Allow popping from introduction, defaults to true. Defaults to true |
| `killswitchService` | The service to override the default killswitch service |
| `showSplashScreen` | A boolean to show the splashScreen or not. Defaults to true |


## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_start) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute
[text](about:blank#blocked)
If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_start/pulls).

## Author

This flutter_start for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>
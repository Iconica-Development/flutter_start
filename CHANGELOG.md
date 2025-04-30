## 4.2.4
- Fixed the userstory to always call the splashScreenFuture and killswitchservice logic when a custom splashScreenBuilder is provided

## 4.2.3
- Added check if introduction should be shown according to the service before showing the introduction at all

## 4.2.2
- Added custom navigator in the root of the navigator user-story

## 4.2.1
- Updated flutter_introduction to 5.0.0

## 4.1.0
- Updated README
- Removed check if the introductions should be shown.
- Updated flutter_introduction to 3.1.0

## 4.0.0
- Added default introduction page.
- Added default splash screen.
- Changed the way the splash screen is enabled/disabled.

## 3.0.0

BREAKING:
- add NavigatorStartUserStory widget
- change homeEntry to an onComplete callback

Other changes:
- add parameter to configuration to supply an implementation of the killswitch service
- call splash handler when no builder is provided
- add mounted check to navigation after async gap for navigator version
- rename myFunction in splashscreen function to splashHandler
- add return after routing on navigator version

## 2.0.5

- Added canPopFromIntroduction to enable/disable popping from introduction screens

## 2.0.4

- Removed `AlwaysShowIntroduction` option, changed naming of `isKillSwitchActive` to `isAllowedToPassThrough`.

## 2.0.3

- Added after splashscreen route

## 2.0.2

- Added configuration options
- Fixed bug with killswitch

## 2.0.1

- Added Iconica Ci

## 2.0.0

- Add support for default configurable splashscreen
- Add introductionpagebuilder
- Upgrade to flutter_introduction 2.1.0
- Change the options to optionbuilders to provide BuildContext

## 1.1.0

- Add killswitch functionality

## 1.0.0

- Initial release

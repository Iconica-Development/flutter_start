// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_introduction/flutter_introduction.dart';
import 'package:flutter_introduction_shared_preferences/flutter_introduction_shared_preferences.dart';
import 'package:flutter_start/src/go_router.dart';
import 'package:flutter_start/src/models/start_configuration.dart';
import 'package:flutter_start/src/routes.dart';
import 'package:flutter_start/src/services/killswitch_service.dart';

import 'package:go_router/go_router.dart';

List<GoRoute> getStartStoryRoutes(
  StartUserStoryConfiguration configuration,
) =>
    <GoRoute>[
      GoRoute(
        path: StartUserStoryRoutes.splashScreen,
        pageBuilder: (context, state) {
          var go = context.go;
          var isAllowedToPassThrough = false;
          var introductionSeen = false;
          String? routeAfterSplash;
          Future<void> splashLoadingMethod() async {
            await Future.wait<void>(
              [
                Future.delayed(
                  Duration.zero,
                  () async {
                    if (configuration.useKillswitch) {
                      var killswitchService = configuration.killswitchService ??
                          DefaultKillswitchService();

                      isAllowedToPassThrough =
                          await killswitchService.isKillswitchActive();
                    }

                    var introService = configuration.introductionService ??
                        IntroductionService(
                          SharedPreferencesIntroductionDataProvider(),
                        );
                    introductionSeen = !await introService.shouldShow();
                    if (context.mounted)
                      routeAfterSplash = await configuration.splashScreenFuture
                              ?.call(context) ??
                          configuration.homeScreenRoute;
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

            if (configuration.useKillswitch && isAllowedToPassThrough) return;

            if (!configuration.showIntroduction || introductionSeen) {
              return go(
                routeAfterSplash ?? StartUserStoryRoutes.home,
              );
            }
            return go(StartUserStoryRoutes.introduction);
          }

          if (configuration.splashScreenBuilder == null) {
            unawaited(splashLoadingMethod());
          }
          return buildScreenWithoutTransition(
            context: context,
            state: state,
            child: configuration.splashScreenBuilder?.call(
                  context,
                  () async => splashLoadingMethod(),
                ) ??
                Scaffold(
                  backgroundColor: configuration.splashScreenBackgroundColor,
                  body: Center(
                    child:
                        configuration.splashScreenCenterWidget?.call(context) ??
                            const SizedBox.shrink(),
                  ),
                ),
          );
        },
      ),
      GoRoute(
        path: StartUserStoryRoutes.introduction,
        pageBuilder: (context, state) {
          var introduction = Introduction(
            service: configuration.introductionService ??
                IntroductionService(
                  SharedPreferencesIntroductionDataProvider(),
                ),
            navigateTo: () {
              context.go(
                configuration.homeScreenRoute ?? StartUserStoryRoutes.home,
              );
            },
            options: configuration.introductionOptionsBuilder?.call(context) ??
                const IntroductionOptions(),
            physics: configuration.introductionScrollPhysics,
            child: configuration.introductionFallbackScreen,
          );

          return buildScreenWithoutTransition(
            context: context,
            state: state,
            child: PopScope(
              canPop: configuration.canPopFromIntroduction,
              child: configuration.introductionBuilder?.call(
                    context,
                    introduction,
                  ) ??
                  Scaffold(
                    body: introduction,
                  ),
            ),
          );
        },
      ),
    ];

// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

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
          return buildScreenWithoutTransition(
            context: context,
            state: state,
            child: configuration.splashScreenBuilder?.call(
                  context,
                  () async {
                    if (configuration.useKillswitch == true) {
                      var isActive =
                          await KillswitchService().isKillswitchActive();
                      if (!isActive) {
                        return;
                      }
                    }
                    if (configuration.showIntroduction == false) {
                      return go(StartUserStoryRoutes.home);
                    }
                    return go(StartUserStoryRoutes.introduction);
                  },
                ) ??
                const Scaffold(
                  body: SizedBox.shrink(),
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
                    SharedPreferencesIntroductionDataProvider()),
            navigateTo: () {
              context.go(StartUserStoryRoutes.home);
            },
            options: configuration.introductionOptions,
            physics: configuration.introductionScrollPhysics,
            child: configuration.introductionFallbackScreen,
          );
          return buildScreenWithoutTransition(
            context: context,
            state: state,
            child: Scaffold(
              body: introduction,
            ),
          );
        },
      ),
      GoRoute(
        path: StartUserStoryRoutes.home,
        pageBuilder: (context, state) {
          var home = configuration.homeEntry;
          return buildScreenWithoutTransition(
            context: context,
            state: state,
            child: Scaffold(
              body: home,
            ),
          );
        },
      ),
    ];

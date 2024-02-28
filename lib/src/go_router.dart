// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Builds a screen with a fade transition.
///
/// The [context] parameter is the [BuildContext] in which this widget is built.
/// The [state] parameter is the [GoRouterState] that contains
/// the current routing state.
/// The [child] parameter is the widget that will be displayed on the screen.
///
/// Returns a [CustomTransitionPage] with a fade transition.
CustomTransitionPage buildScreenWithFadeTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );

/// Builds a screen without any transition.
///
/// The [context] parameter is the [BuildContext] in which this widget is built.
/// The [state] parameter is the [GoRouterState] that contains
/// the current routing state.
/// The [child] parameter is the widget that will be displayed on the screen.
///
/// Returns a [CustomTransitionPage] without any transition.
CustomTransitionPage buildScreenWithoutTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          child,
    );

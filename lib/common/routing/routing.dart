import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouteName {
  static const String homeScreen = 'homeScreen';
  static const String processScreen = 'processScreen';
  static const String resultListScreen = 'resultListScreen';
  static const String previewScreen = 'previewScreen';
}




GoRouter createRouter() => GoRouter(
  initialLocation: '/',
  routes: [
/*
    GoRoute(
      name: RouteName.homeScreen,
      path: '/',
      pageBuilder: (context, state) => buildPageWithPlatformTransition<void>(
        context: context,
        state: state,
        child: const OnboardingPrimaryGoalPage(),
      ),
    ),
    GoRoute(
      name: RouteName.processScreen,
      path: '/${RouteName.processScreen}',
      pageBuilder: (context, state) => buildPageWithPlatformTransition<void>(
        context: context,
        state: state,
        child: const OnboardingVisualizingSuccessPage(),
      ),
    ),
    GoRoute(
      name: RouteName.resultListScreen,
      path: '/${RouteName.resultListScreen}',
      pageBuilder: (context, state) => buildPageWithPlatformTransition<void>(
        context: context,
        state: state,
        child: const OnboardingProvenResultsPage(),
      ),
    ),
    GoRoute(
      name: RouteName.previewScreen,
      path: '/${RouteName.previewScreen}',
      pageBuilder: (context, state) => buildPageWithPlatformTransition<void>(
        context: context,
        state: state,
        child: const OnboardingVitaminsPage(),
      ),
    ),
*/
  ],
);




Page<T> buildPageWithPlatformTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return Platform.isIOS
      ? CupertinoPage(key: state.pageKey, child: child)
      : MaterialPage(key: state.pageKey, child: child);
}

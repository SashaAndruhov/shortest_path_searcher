import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shortest_path_searcher/features/search_path/presentation/pages/home_page.dart';
import 'package:shortest_path_searcher/features/search_path/presentation/pages/process_page.dart';

class RouteName {
  static const String homeScreen = 'homeScreen';
  static const String processScreen = 'processScreen';
  static const String resultListScreen = 'resultListScreen';
  static const String previewScreen = 'previewScreen';
}




GoRouter createRouter() => GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: RouteName.homeScreen,
      path: '/',
      pageBuilder: (context, state) => buildPageWithPlatformTransition<void>(
        context: context,
        state: state,
        child: const HomePage(),
      ),
    ),
    GoRoute(
      name: RouteName.processScreen,
      path: '/${RouteName.processScreen}',
      pageBuilder: (context, state) => buildPageWithPlatformTransition<void>(
        context: context,
        state: state,
        child: const ProcessPage(),
      ),
    ),
/*
    GoRoute(
      name: RouteName.resultListScreen,
      path: '/${RouteName.resultListScreen}',
      pageBuilder: (context, state) => buildPageWithPlatformTransition<void>(
        context: context,
        state: state,
        child: const ResultListPage(),
      ),
    ),
    GoRoute(
      name: RouteName.previewScreen,
      path: '/${RouteName.previewScreen}',
      pageBuilder: (context, state) => buildPageWithPlatformTransition<void>(
        context: context,
        state: state,
        child: const PreviewPage(),
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

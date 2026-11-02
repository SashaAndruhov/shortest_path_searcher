import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_path_searcher/common/di/di.dart';
import 'package:shortest_path_searcher/common/routing/routing.dart';
import 'package:shortest_path_searcher/features/search_path/presentation/managers/home_page_cubit.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<HomePageCubit>()..loadInitialData(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: true,
        title: 'Path searcher',
        routerConfig: createRouter(),
      ),
    );
  }
}


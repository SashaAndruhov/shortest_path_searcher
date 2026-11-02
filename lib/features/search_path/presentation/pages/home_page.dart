import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_path_searcher/features/search_path/presentation/managers/home_page_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<HomePageCubit, HomePageState>(
      builder: (blockContext, state) {
        return Column(
          children: [
          ],
        );
      },
    ));
  }

}

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shortest_path_searcher/features/search_path/data/repository/data_repository.dart';

part 'home_page_state.dart';

@lazySingleton
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(
    this._repository,
  ) : super(HomePageState());


  final DataRepository _repository;



  Future<void> loadInitialData() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    final savedUrl = await _repository.getSavedUrl();


    emit(
      state.copyWith(
        isLoading: false,
        url: savedUrl,
      ),
    );
  }

}

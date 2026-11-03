import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shortest_path_searcher/common/data/exception.dart';
import 'package:shortest_path_searcher/features/search_path/data/models/processing_field_model.dart';
import 'package:shortest_path_searcher/features/search_path/data/repository/data_repository.dart';

part 'home_page_state.dart';

const _invalidUrlMessage = 'Please enter a valid URL';
const _unknownErrorMessage = 'Something went wrong. Please try again';

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

  void onUrlChanged(String value) {
    emit(state.copyWith(
      url: value,
      isLoaded: false,
      clearErrors: true,
    ));
  }

  Future<void> start(String rawUrl) async {
    final url = rawUrl.trim();
    if (!_isValidUrl(url)) {
      emit(state.copyWith(
        url: url,
        validationError: _invalidUrlMessage,
        clearErrors: true,
      ));
      return;
    }

    emit(state.copyWith(
      url: url,
      isLoading: true,
      isLoaded: false,
      clearErrors: true,
    ));
    await _repository.saveUrl(url);

    final result = await _repository.getFieldsList(url);
    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: _failureMessage(failure),
      )),
      (response) => response.error
          ? emit(state.copyWith(
              isLoading: false,
              errorMessage: response.message.isNotEmpty ? response.message : _unknownErrorMessage,
            ))
          : emit(state.copyWith(
              isLoading: false,
              isLoaded: true,
              fields: response.data,
            )),
    );
  }

  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  String _failureMessage(Failure failure) {
    if (failure is NetworkFailure && failure.message.isNotEmpty) {
      return failure.message;
    }
    return _unknownErrorMessage;
  }

}

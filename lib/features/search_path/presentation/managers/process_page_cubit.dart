import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shortest_path_searcher/common/data/exception.dart';
import 'package:shortest_path_searcher/features/search_path/data/models/coordinate_model.dart';
import 'package:shortest_path_searcher/features/search_path/data/models/path_result_model.dart';
import 'package:shortest_path_searcher/features/search_path/data/models/processing_field_model.dart';
import 'package:shortest_path_searcher/features/search_path/data/models/processing_result_model.dart';
import 'package:shortest_path_searcher/features/search_path/data/repository/data_repository.dart';
import 'package:shortest_path_searcher/features/search_path/domain/grid.dart';
import 'package:shortest_path_searcher/features/search_path/domain/path_finder.dart';
import 'package:shortest_path_searcher/features/search_path/domain/point.dart';

part 'process_page_state.dart';

const _unknownErrorMessage = 'Something went wrong. Please try again';

@injectable
class ProcessPageCubit extends Cubit<ProcessPageState> {
  ProcessPageCubit(this._repository) : super(const ProcessPageState());

  final DataRepository _repository;
  final ShortestPathFinder _pathFinder = const ShortestPathFinder();

  Future<void> calculate(List<ProcessingFieldModel> fields) async {
    await Future<void>.delayed(Duration(milliseconds: 400));
    final results = <ProcessingResultModel>[];
    for (var i = 0; i < fields.length; i++) {
      final solvedField = _solve(fields[i]);
      if (solvedField != null) {
        results.add(solvedField);
      }
      if (isClosed) return;
      emit(state.copyWith(progress: (i + 1) / fields.length, results: List.unmodifiable(results)));
    }
    if (isClosed) return;

    emit(state.copyWith(status: ProcessStatus.calculated, progress: 1, results: List.unmodifiable(results)));
  }

  Future<void> sendResults(String url) async {
    emit(state.copyWith(status: ProcessStatus.sending, clearError: true));

    final result = await _repository.sendResults(url, state.results);
    if (isClosed) return;
    result.fold(
      (failure) => emit(state.copyWith(status: ProcessStatus.calculated, errorMessage: _failureMessage(failure))),
      (response) => response.error
          ? emit(
              state.copyWith(
                status: ProcessStatus.calculated,
                errorMessage: response.message.isNotEmpty ? response.message : _unknownErrorMessage,
              ),
            )
          : emit(state.copyWith(status: ProcessStatus.sent)),
    );
  }

  ProcessingResultModel? _solve(ProcessingFieldModel field) {
    final grid = Grid.fromRows(field.field);
    if (!grid.isValid) return null;
    final path = _pathFinder.find(grid, Point(field.start.x, field.start.y), Point(field.end.x, field.end.y));
    return ProcessingResultModel(
      id: field.id,
      result: PathResultModel(
        steps: path?.map((point) => CoordinateModel(x: point.x, y: point.y)).toList(),
        path: path?.join('->'),
      ),
    );
  }

  String _failureMessage(Failure failure) {
    if (failure is NetworkFailure && failure.message.isNotEmpty) {
      return failure.message;
    }
    return _unknownErrorMessage;
  }
}

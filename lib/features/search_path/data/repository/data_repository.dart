import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shortest_path_searcher/common/data/exception.dart';
import 'package:shortest_path_searcher/features/search_path/data/models/data_for_processing_response.dart';
import 'package:shortest_path_searcher/features/search_path/data/services/data_api_service.dart';
import 'package:shortest_path_searcher/features/search_path/data/services/local_data_source.dart';

abstract class DataRepository {
  Future<Either<Failure, DataForProcessingResponse>> getFieldsList(String url);

  Future<String?> getSavedUrl();

}

@Injectable(as: DataRepository)
class DataRepositoryImpl implements DataRepository {
  DataRepositoryImpl(this._dataApiService, this._localDataSource);

  final DataApiService _dataApiService;
  final LocalDataSource _localDataSource;

  @override
  Future<Either<Failure, DataForProcessingResponse>> getFieldsList(String url) async {
    try {
      final response = await _dataApiService.getFieldsList(url);
      return Right(response);
    } on DioException catch (e, stack) {
      final error = NetworkFailure.httpError(error: e, stack: stack);
      return Left(error);
    } catch (e, stack) {
      final failure = parseError(error: e, stack: stack);
      return Left(failure);
    }
  }

  @override
  Future<String?> getSavedUrl() {
    return _localDataSource.getSavedUrl();
  }


}

import 'package:dio/dio.dart';

enum ErrorType { http, network, unknown, timeOut, parse}

class Failure  implements Exception {
  const Failure();

}

class NetworkFailure extends Failure {

  const NetworkFailure._({
    required this.error,
    required this.message,
    this.stack,
    required this.errorType,
    this.statusCode,
  });

  factory NetworkFailure.unknownError({required Object error, StackTrace? stack}){
    return NetworkFailure._(error: error, message: error.toString(), stack: stack, errorType: ErrorType.unknown);
  }

  factory NetworkFailure.parseError({required Object error, StackTrace? stack}){
    return NetworkFailure._(error: error, message: error.toString(), stack: stack, errorType: ErrorType.parse);
  }


  factory NetworkFailure.httpError({required DioException error, StackTrace? stack}) {
    var errorType = error.response != null ? ErrorType.http : ErrorType.network;
    switch(error.type){
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorType = ErrorType.timeOut;
        break;
      default:
        errorType = error.response != null ? ErrorType.http : ErrorType.network;
    }

    var message =  error.response?.statusMessage ?? '';
    if (errorType == ErrorType.http && error.response?.data is Map<String, dynamic>) {
      final dataMessage = _getDataMessage(error.response?.data);
      if (dataMessage != null) {
        message = dataMessage;
      }
    }
    if (message.isEmpty) {
      message = error.message ?? '';
    }
    return NetworkFailure._(
      error: error,
      message: message,
      stack: stack,
      errorType: errorType,
      statusCode: error.response?.statusCode,
    );
  }


  final Object error;
  final String message;
  final StackTrace? stack;
  final ErrorType errorType;
  final int? statusCode;

  static String? _getDataMessage(Map<String, dynamic> data) {
    if (data['message'] != null) {
      return data['message'];
    }
    return null;
  }

}


NetworkFailure parseError({required Object error, StackTrace? stack}){
  if(error is TypeError || error is FormatException || error is ArgumentError){
    return NetworkFailure.parseError(error: error, stack: stack);
  }else{
    return NetworkFailure.unknownError(error: error, stack: stack);
  }
}

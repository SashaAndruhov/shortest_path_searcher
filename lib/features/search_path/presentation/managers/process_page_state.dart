part of 'process_page_cubit.dart';

enum ProcessStatus { calculating, calculated, sending, sent }

class ProcessPageState extends Equatable {
  const ProcessPageState({
    this.status = ProcessStatus.calculating,
    this.progress = 0,
    this.results = const [],
    this.errorMessage,
  });

  final ProcessStatus status;
  final double progress;
  final List<ProcessingResultModel> results;
  final String? errorMessage;



  ProcessPageState copyWith({
    ProcessStatus? status,
    double? progress,
    List<ProcessingResultModel>? results,
    String? errorMessage,
    bool clearError = false,
  }) => ProcessPageState(
    status: status ?? this.status,
    progress: progress ?? this.progress,
    results: results ?? this.results,
    errorMessage: clearError ? errorMessage : errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    status,
    progress,
    results,
    errorMessage,
  ];
}

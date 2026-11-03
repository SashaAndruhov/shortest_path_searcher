part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  const HomePageState({
    this.url,
    this.isLoading = false,
    this.isLoaded = false,
    this.validationError,
    this.errorMessage,
    this.fields = const [],
  });

  final String? url;
  final bool isLoading;
  final bool isLoaded;
  final String? validationError;
  final String? errorMessage;
  final List<ProcessingFieldModel> fields;



  HomePageState copyWith({
    String? url,
    bool? isLoading,
    bool? isLoaded,
    String? validationError,
    String? errorMessage,
    List<ProcessingFieldModel>? fields,
    bool clearErrors = false,
  }) => HomePageState(
    url: url ?? this.url,
    isLoading: isLoading ?? this.isLoading,
    isLoaded: isLoaded ?? this.isLoaded,
    validationError: clearErrors ? validationError : validationError ?? this.validationError,
    errorMessage: clearErrors ? errorMessage : errorMessage ?? this.errorMessage,
    fields: fields ?? this.fields,
  );

  @override
  List<Object?> get props => [
    url,
    isLoading,
    isLoaded,
    validationError,
    errorMessage,
    fields,
  ];
}

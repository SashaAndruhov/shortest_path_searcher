part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  const HomePageState({
    this.url,
    this.isLoading = false,
    this.isError = false,
  });

  final String? url;
  final bool isLoading;
  final bool isError;



  HomePageState copyWith({
    String? url,
    bool? isLoading,
    bool? isError,
  }) => HomePageState(
    url: url ?? this.url,
    isLoading: isLoading ?? this.isLoading,
    isError: isError ?? this.isError,
  );

  @override
  List<Object?> get props => [
    url,
    isLoading,
    isError,
  ];
}

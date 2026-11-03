import 'package:json_annotation/json_annotation.dart';

part 'send_results_response.g.dart';

@JsonSerializable(createToJson: false)
class SendResultsResponse {
  const SendResultsResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory SendResultsResponse.fromJson(Map<String, dynamic> json) => _$SendResultsResponseFromJson(json);


  @JsonKey(defaultValue: false)
  final bool error;
  @JsonKey(defaultValue: '')
  final String message;
  @JsonKey(defaultValue: [])
  final List<ResultCheckModel> data;

}

@JsonSerializable(createToJson: false)
class ResultCheckModel {
  const ResultCheckModel({
    required this.id,
    required this.correct,
  });

  factory ResultCheckModel.fromJson(Map<String, dynamic> json) => _$ResultCheckModelFromJson(json);


  @JsonKey(defaultValue: '')
  final String id;
  @JsonKey(defaultValue: false)
  final bool correct;

}

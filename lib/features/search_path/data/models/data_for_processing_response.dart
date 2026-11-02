import 'package:json_annotation/json_annotation.dart';
import 'package:shortest_path_searcher/features/search_path/data/models/processing_field_model.dart';

part 'data_for_processing_response.g.dart';

@JsonSerializable()
class DataForProcessingResponse {
  const DataForProcessingResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory DataForProcessingResponse.fromJson(Map<String, dynamic> json) => _$DataForProcessingResponseFromJson(json);


  @JsonKey(defaultValue: false)
  final bool error;
  @JsonKey(defaultValue: '')
  final String message;
  @JsonKey(defaultValue: [])
  final List<ProcessingFieldModel> data;



}

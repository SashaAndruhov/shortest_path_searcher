import 'package:json_annotation/json_annotation.dart';
import 'package:shortest_path_searcher/features/search_path/data/models/path_result_model.dart';

part 'processing_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProcessingResultModel {
  const ProcessingResultModel({
    required this.id,
    required this.result,
  });

  factory ProcessingResultModel.fromJson(Map<String, dynamic> json) => _$ProcessingResultModelFromJson(json);


  final String id;
  final PathResultModel result;


  Map<String, dynamic> toJson() => _$ProcessingResultModelToJson(this);

}

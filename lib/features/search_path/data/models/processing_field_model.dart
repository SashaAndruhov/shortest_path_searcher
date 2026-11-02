import 'package:json_annotation/json_annotation.dart';
import 'package:shortest_path_searcher/features/search_path/data/models/coordinate_model.dart';

part 'processing_field_model.g.dart';

@JsonSerializable()
class ProcessingFieldModel {
  const ProcessingFieldModel({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory ProcessingFieldModel.fromJson(Map<String, dynamic> json) => _$ProcessingFieldModelFromJson(json);


  final String id;
  final List<String> field;
  final CoordinateModel start;
  final CoordinateModel end;

  Map<String, dynamic> toJson() => _$ProcessingFieldModelToJson(this);


}

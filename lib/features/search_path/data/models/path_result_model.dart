import 'package:json_annotation/json_annotation.dart';
import 'package:shortest_path_searcher/features/search_path/data/models/coordinate_model.dart';

part 'path_result_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class PathResultModel {
  const PathResultModel({
    required this.steps,
    required this.path,
  });

  factory PathResultModel.fromJson(Map<String, dynamic> json) => _$PathResultModelFromJson(json);


  final List<CoordinateModel>? steps;
  final String? path;

  String get displayPath {
    final steps = this.steps;
    if (steps == null || steps.isEmpty) return 'No path found';
    return steps.map((step) => '(${step.x}.${step.y})').join(' -> ');
  }


  Map<String, dynamic> toJson() => _$PathResultModelToJson(this);

}

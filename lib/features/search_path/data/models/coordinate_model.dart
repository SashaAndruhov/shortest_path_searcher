import 'package:json_annotation/json_annotation.dart';

part 'coordinate_model.g.dart';

@JsonSerializable()
class CoordinateModel {
  const CoordinateModel({
    required this.x,
    required this.y,
  });

  factory CoordinateModel.fromJson(Map<String, dynamic> json) => _$CoordinateModelFromJson(json);


  @JsonKey(toJson: _coordinateToJson)
  final  int x;
  @JsonKey(toJson: _coordinateToJson)
  final int y;


  Map<String, dynamic> toJson() => _$CoordinateModelToJson(this);

  static String _coordinateToJson(int value) =>
      value.toString();

}

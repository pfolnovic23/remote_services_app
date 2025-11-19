import 'package:json_annotation/json_annotation.dart';

part 'pjesma_models.g.dart';

@JsonSerializable()
class PjesmaModel {
  final int id;
  final String ime;
  final String grupa;
  final String trajanje;
  final int godina;

  PjesmaModel({
    required this.id,
    required this.ime,
    required this.grupa,
    required this.trajanje,
    required this.godina,
  });

  factory PjesmaModel.fromJson(Map<String, dynamic> json) =>
      _$PjesmaModelFromJson(json);

  Map<String, dynamic> toJson() => _$PjesmaModelToJson(this);
}

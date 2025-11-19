import 'package:json_annotation/json_annotation.dart';

part 'reper_models.g.dart';

@JsonSerializable()
class ReperModel {
  final int id;
  final String ime;
  @JsonKey(name: 'pravo_ime')
  final String pravoIme;
  final String grupa;
  final String grad;

  ReperModel({
    required this.id,
    required this.ime,
    required this.pravoIme,
    required this.grupa,
    required this.grad,
  });

  factory ReperModel.fromJson(Map<String, dynamic> json) =>
      _$ReperModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReperModelToJson(this);
}

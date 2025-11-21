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

  factory ReperModel.fromJson(Map<String, dynamic> json) {
    return ReperModel(
      id: json['id'] is String ? int.parse(json['id']) : json['id'] as int,
      ime: json['ime'] as String,
      pravoIme: json['pravo_ime'] as String,
      grupa: json['grupa'] as String,
      grad: json['grad'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$ReperModelToJson(this);
}

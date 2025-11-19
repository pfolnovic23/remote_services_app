// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reper_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReperModel _$ReperModelFromJson(Map<String, dynamic> json) => ReperModel(
      id: (json['id'] as num).toInt(),
      ime: json['ime'] as String,
      pravoIme: json['pravo_ime'] as String,
      grupa: json['grupa'] as String,
      grad: json['grad'] as String,
    );

Map<String, dynamic> _$ReperModelToJson(ReperModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'pravo_ime': instance.pravoIme,
      'grupa': instance.grupa,
      'grad': instance.grad,
    };

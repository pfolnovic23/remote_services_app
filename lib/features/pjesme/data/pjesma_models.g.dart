// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pjesma_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PjesmaModel _$PjesmaModelFromJson(Map<String, dynamic> json) => PjesmaModel(
      id: (json['id'] as num).toInt(),
      ime: json['ime'] as String,
      grupa: json['grupa'] as String,
      trajanje: json['trajanje'] as String,
      godina: (json['godina'] as num).toInt(),
    );

Map<String, dynamic> _$PjesmaModelToJson(PjesmaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'grupa': instance.grupa,
      'trajanje': instance.trajanje,
      'godina': instance.godina,
    };

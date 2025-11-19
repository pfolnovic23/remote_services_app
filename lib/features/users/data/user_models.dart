import 'package:json_annotation/json_annotation.dart';

part 'user_models.g.dart';

@JsonSerializable()
class UserModel {
  final int? id;
  final String name;
  final String email;
  final String? phone;
  final String? website;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.phone,
    this.website,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

// Keep User as an alias for backward compatibility
typedef User = UserModel;

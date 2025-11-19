import 'package:json_annotation/json_annotation.dart';

part 'product_models.g.dart';

@JsonSerializable()
class ProductModel {
  final int? id;
  final String title;
  final String body;
  final int userId;

  ProductModel({
    this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

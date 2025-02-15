import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/card.dart';

part 'card_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class CardModel extends CardEntity {
  @HiveField(0)
  @JsonKey(required: true)
  final String id;

  @HiveField(1)
  @JsonKey(required: true)
  final String name;

  @HiveField(2)
  @JsonKey(required: true)
  final String cardholder;

  @HiveField(3)
  @JsonKey(required: true)
  final int balance;

  @HiveField(4)
  @JsonKey(required: true)
  final String color;

  CardModel({
    required this.id,
    required this.name,
    required this.cardholder,
    required this.balance,
    required this.color,
  }) : super(
          id: id,
          name: name,
          cardholder: cardholder,
          balance: balance,
          color: color,
        );

  factory CardModel.fromJson(Map<String, dynamic> json) => _$CardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardModelToJson(this);
}

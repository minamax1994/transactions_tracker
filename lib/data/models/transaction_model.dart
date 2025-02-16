import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/transaction.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class TransactionModel extends Transaction {
  @HiveField(0)
  @JsonKey(required: true)
  final String id;

  @HiveField(1)
  @JsonKey(required: true)
  final String name;

  @HiveField(2)
  @JsonKey(required: true)
  final String merchant;

  @HiveField(3)
  @JsonKey(required: true)
  final int billingAmount;

  @HiveField(4)
  @JsonKey(required: true)
  final String billingCurrency;

  @HiveField(5)
  @JsonKey(required: true)
  final String image;

  @HiveField(6)
  @JsonKey(
    required: true,
    fromJson: _dateFromJson,
    toJson: _dateToJson,
  )
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.name,
    required this.merchant,
    required this.billingAmount,
    required this.billingCurrency,
    required this.image,
    required this.date,
  }) : super(
          id: id,
          name: name,
          merchant: merchant,
          billingAmount: billingAmount,
          billingCurrency: billingCurrency,
          image: image,
          date: date,
        );

  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  static DateTime _dateFromJson(int seconds) => DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

  static int _dateToJson(DateTime date) => date.millisecondsSinceEpoch ~/ 1000;
}

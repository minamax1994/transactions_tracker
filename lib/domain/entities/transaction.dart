import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String id;
  final String name;
  final String merchant;
  final int billingAmount;
  final String billingCurrency;
  final String image;
  final DateTime date;

  Transaction({
    required this.id,
    required this.name,
    required this.merchant,
    required this.billingAmount,
    required this.billingCurrency,
    required this.image,
    required this.date,
  });

  @override
  List<Object?> get props => [id, name, merchant, billingAmount, billingCurrency, image, date];
}

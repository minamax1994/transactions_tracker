import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final String id;
  final String name;
  final String cardholder;
  final int balance;
  final String color;

  CardEntity({
    required this.id,
    required this.name,
    required this.cardholder,
    required this.balance,
    required this.color,
  });

  @override
  List<Object?> get props => [id, name, cardholder, balance, color];
}

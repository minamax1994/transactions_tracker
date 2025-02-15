import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failures.dart';
import '../entities/card.dart';
import '../repositories/card_repository.dart';

class CreateCard {
  final CardRepository repository;

  CreateCard(this.repository);

  Future<Either<Failure, CardEntity>> call(CardParams params) async {
    return await repository.createCard(params);
  }
}

class CardParams extends Equatable {
  final String name;
  final String cardholder;
  final int balance;
  final String color;

  CardParams({
    required this.name,
    required this.cardholder,
    required this.balance,
    required this.color,
  });

  @override
  List<Object> get props => [name, cardholder, balance, color];
}

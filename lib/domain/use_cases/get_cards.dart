import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/card.dart';
import '../repositories/card_repository.dart';

class GetCards {
  final CardRepository repository;

  GetCards(this.repository);

  Future<Either<Failure, List<CardEntity>>> call() async {
    return await repository.getCards();
  }
}

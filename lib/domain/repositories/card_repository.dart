import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/card.dart';
import '../use_cases/create_card.dart';

abstract class CardRepository {
  Future<Either<Failure, CardEntity>> createCard(CardParams params);
  Future<Either<Failure, List<CardEntity>>> getCards();
}

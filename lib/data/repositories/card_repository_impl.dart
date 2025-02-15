import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/card.dart';
import '../../domain/repositories/card_repository.dart';
import '../../domain/use_cases/create_card.dart';
import '../data_sources/local/card_local_data_source.dart';
import '../models/card_model.dart';

class CardRepositoryImpl implements CardRepository {
  final CardLocalDataSource localDataSource;
  final Uuid uuid;

  CardRepositoryImpl({
    required this.localDataSource,
    required this.uuid,
  });

  @override
  Future<Either<Failure, CardEntity>> createCard(CardParams params) async {
    try {
      final cardModel = CardModel(
        id: uuid.v4(),
        name: params.name,
        cardholder: params.cardholder,
        balance: params.balance,
        color: params.color,
      );

      await localDataSource.saveCard(cardModel);
      return Right(cardModel);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CardEntity>>> getCards() async {
    try {
      final cards = await localDataSource.getCards();
      return Right(cards);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}

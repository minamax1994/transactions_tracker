import 'package:hive/hive.dart';

import '../../models/card_model.dart';

abstract class CardLocalDataSource {
  Future<List<CardModel>> getCards();
  Future<void> saveCard(CardModel card);
}

class CardLocalDataSourceImpl implements CardLocalDataSource {
  final Box<CardModel> cardBox;

  CardLocalDataSourceImpl({required this.cardBox});

  @override
  Future<List<CardModel>> getCards() async {
    return cardBox.values.toList();
  }

  @override
  Future<void> saveCard(CardModel card) async {
    await cardBox.put(card.id, card);
  }
}

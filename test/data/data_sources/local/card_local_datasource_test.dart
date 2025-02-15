import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:transactions_tracker/data/data_sources/local/card_local_data_source.dart';
import 'package:transactions_tracker/data/models/card_model.dart';

import 'card_local_datasource_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late CardLocalDataSourceImpl dataSource;
  late MockBox<CardModel> mockBox;

  setUp(() {
    mockBox = MockBox<CardModel>();
    dataSource = CardLocalDataSourceImpl(cardBox: mockBox);
  });

  group('getCards', () {
    final tCards = [
      CardModel(
        id: "1",
        name: 'name 1',
        cardholder: 'cardholder 1',
        balance: 200,
        color: "#FF0000",
      ),
      CardModel(
        id: "2",
        name: 'name 2',
        cardholder: 'cardholder 2',
        balance: 500,
        color: "#FFFFFF",
      ),
    ];

    test('should return cards when it exists in the cache', () async {
      when(mockBox.values).thenReturn(tCards);

      final result = await dataSource.getCards();

      verify(mockBox.values);
      expect(result, equals(tCards));
    });
  });

  group('saveCard', () {
    final tCard = CardModel(
      id: "1",
      name: 'name 1',
      cardholder: 'cardholder 1',
      balance: 200,
      color: "#FF0000",
    );

    test('should save the card', () async {
      when(mockBox.put(any, any)).thenAnswer((_) async => {});

      await dataSource.saveCard(tCard);

      verify(mockBox.put(tCard.id, tCard));
    });
  });
}

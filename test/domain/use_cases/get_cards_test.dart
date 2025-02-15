import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:transactions_tracker/domain/entities/card.dart';
import 'package:transactions_tracker/domain/repositories/card_repository.dart';
import 'package:transactions_tracker/domain/use_cases/get_cards.dart';

import 'get_cards_test.mocks.dart';

@GenerateMocks([CardRepository])
void main() {
  late GetCards useCase;
  late MockCardRepository mockCardRepository;

  setUp(() {
    mockCardRepository = MockCardRepository();
    useCase = GetCards(mockCardRepository);
  });

  final tCards = [
    CardEntity(
      id: "1",
      name: 'name 1',
      cardholder: 'cardholder 1',
      balance: 200,
      color: "#FF0000",
    ),
    CardEntity(
      id: "2",
      name: 'name 2',
      cardholder: 'cardholder 2',
      balance: 500,
      color: "#FFFFFF",
    ),
  ];

  test('should get cards from the repository', () async {
    // arrange
    when(mockCardRepository.getCards()).thenAnswer((_) async => Right(tCards));

    // act
    final result = await useCase();

    // assert
    expect(result, Right(tCards));
    verify(mockCardRepository.getCards());
    verifyNoMoreInteractions(mockCardRepository);
  });
}

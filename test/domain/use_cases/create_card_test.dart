import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:transactions_tracker/domain/entities/card.dart';
import 'package:transactions_tracker/domain/repositories/card_repository.dart';
import 'package:transactions_tracker/domain/use_cases/create_card.dart';
import 'package:uuid/uuid.dart';

import 'create_card_test.mocks.dart';

@GenerateMocks([CardRepository, Uuid])
void main() {
  late CreateCard useCase;
  late MockCardRepository mockCardRepository;
  late MockUuid mockUuid;

  setUp(() {
    mockCardRepository = MockCardRepository();
    useCase = CreateCard(mockCardRepository);
    mockUuid = MockUuid();
  });

  final tCardParams = CardParams(
    name: 'name 1',
    cardholder: 'cardholder 1',
    balance: 200,
    color: "#FF0000",
  );
  final tCardEntity = CardEntity(
    id: "1",
    name: 'name 1',
    cardholder: 'cardholder 1',
    balance: 200,
    color: "#FF0000",
  );

  test('should create card from the repository', () async {
    // arrange
    when(mockUuid.v4()).thenAnswer((_) => "1");
    when(mockCardRepository.createCard(any)).thenAnswer((_) async => Right(tCardEntity));

    // act
    final result = await useCase(tCardParams);

    // assert
    expect(result, Right(tCardEntity));
    verify(mockCardRepository.createCard(tCardParams));
    verifyNoMoreInteractions(mockCardRepository);
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:transactions_tracker/core/error/failures.dart';
import 'package:transactions_tracker/domain/entities/card.dart';
import 'package:transactions_tracker/domain/use_cases/get_cards.dart';
import 'package:transactions_tracker/presentation/bloc/cards/cards_cubit.dart';
import 'package:transactions_tracker/presentation/bloc/cards/cards_state.dart';

import 'cards_cubit_test.mocks.dart';

@GenerateMocks([GetCards])
void main() {
  late MockGetCards mockGetCards;
  late CardsCubit transactionsCubit;

  setUp(() {
    mockGetCards = MockGetCards();
    transactionsCubit = CardsCubit(getCards: mockGetCards);
  });

  tearDown(() {
    transactionsCubit.close();
  });

  test('initial state should be CardsInitial', () {
    expect(transactionsCubit.state, equals(CardsInitial()));
  });

  group('getCards', () {
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

    blocTest<CardsCubit, CardsState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetCards()).thenAnswer((_) async => Right(tCards));
        return transactionsCubit;
      },
      act: (cubit) => cubit.getCardsList(),
      expect: () => [
        CardsLoading(),
        CardsLoaded(tCards),
      ],
    );

    blocTest<CardsCubit, CardsState>(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(mockGetCards()).thenAnswer((_) async => Left(ServerFailure()));
        return transactionsCubit;
      },
      act: (cubit) => cubit.getCardsList(),
      expect: () => [
        CardsLoading(),
        const CardsError('ServerFailure(Server Error)'),
      ],
    );
  });
}

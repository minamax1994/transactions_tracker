import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:transactions_tracker/core/error/failures.dart';
import 'package:transactions_tracker/domain/entities/card.dart';
import 'package:transactions_tracker/domain/use_cases/create_card.dart';
import 'package:transactions_tracker/presentation/bloc/card/card_cubit.dart';
import 'package:transactions_tracker/presentation/bloc/card/card_state.dart';

import 'card_cubit_test.mocks.dart';

@GenerateMocks([CreateCard])
void main() {
  late MockCreateCard mockCreateCard;
  late CardCubit transactionCubit;

  setUp(() {
    mockCreateCard = MockCreateCard();
    transactionCubit = CardCubit(createCard: mockCreateCard);
  });

  tearDown(() {
    transactionCubit.close();
  });

  test('initial state should be CardInitial', () {
    expect(transactionCubit.state, equals(CardInitial()));
  });

  group('getCard', () {
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

    blocTest<CardCubit, CardState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockCreateCard.call(tCardParams)).thenAnswer((_) async => Right(tCardEntity));
        return transactionCubit;
      },
      act: (cubit) => cubit.createNewCard(
        name: tCardParams.name,
        cardholder: tCardParams.cardholder,
        balance: tCardParams.balance,
        color: tCardParams.color,
      ),
      expect: () => [
        CardLoading(),
        CardCreated(tCardEntity),
      ],
    );

    blocTest<CardCubit, CardState>(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(mockCreateCard.call(tCardParams)).thenAnswer((_) async => Left(ServerFailure()));
        return transactionCubit;
      },
      act: (cubit) => cubit.createNewCard(
        name: tCardParams.name,
        cardholder: tCardParams.cardholder,
        balance: tCardParams.balance,
        color: tCardParams.color,
      ),
      expect: () => [
        CardLoading(),
        const CardError('ServerFailure(Server Error)'),
      ],
    );
  });
}

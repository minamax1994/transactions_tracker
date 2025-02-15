import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:transactions_tracker/core/error/failures.dart';
import 'package:transactions_tracker/domain/entities/transaction.dart';
import 'package:transactions_tracker/domain/use_cases/get_transaction.dart';
import 'package:transactions_tracker/presentation/bloc/transaction/transaction_cubit.dart';
import 'package:transactions_tracker/presentation/bloc/transaction/transaction_state.dart';

import 'transaction_cubit_test.mocks.dart';

@GenerateMocks([GetTransaction])
void main() {
  late MockGetTransaction mockGetTransaction;
  late TransactionCubit transactionCubit;

  setUp(() {
    mockGetTransaction = MockGetTransaction();
    transactionCubit = TransactionCubit(getTransaction: mockGetTransaction);
  });

  tearDown(() {
    transactionCubit.close();
  });

  test('initial state should be TransactionInitial', () {
    expect(transactionCubit.state, equals(TransactionInitial()));
  });

  group('getTransaction', () {
    final tId = '1';
    final tTransaction = Transaction(
      id: tId,
      name: 'name 1',
      merchant: 'merchant 1',
      billingAmount: 94,
      billingCurrency: "ILS",
      image: 'https://loremflickr.com/640/480/nature',
      date: DateTime.fromMillisecondsSinceEpoch(1736240779),
    );

    blocTest<TransactionCubit, TransactionState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTransaction(tId)).thenAnswer((_) async => Right(tTransaction));
        return transactionCubit;
      },
      act: (cubit) => cubit.getTransactionDetails(tId),
      expect: () => [
        TransactionLoading(),
        TransactionLoaded(tTransaction),
      ],
    );

    blocTest<TransactionCubit, TransactionState>(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(mockGetTransaction(tId)).thenAnswer((_) async => Left(ServerFailure()));
        return transactionCubit;
      },
      act: (cubit) => cubit.getTransactionDetails(tId),
      expect: () => [
        TransactionLoading(),
        const TransactionError('ServerFailure(Server Error)'),
      ],
    );
  });
}

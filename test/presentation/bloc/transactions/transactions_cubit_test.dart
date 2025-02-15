import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:transactions_tracker/core/error/failures.dart';
import 'package:transactions_tracker/domain/entities/transaction.dart';
import 'package:transactions_tracker/domain/use_cases/get_transactions.dart';
import 'package:transactions_tracker/presentation/bloc/transactions/transactions_cubit.dart';
import 'package:transactions_tracker/presentation/bloc/transactions/transactions_state.dart';

import 'transactions_cubit_test.mocks.dart';

@GenerateMocks([GetTransactions])
void main() {
  late MockGetTransactions mockGetTransactions;
  late TransactionsCubit transactionsCubit;

  setUp(() {
    mockGetTransactions = MockGetTransactions();
    transactionsCubit = TransactionsCubit(getTransactions: mockGetTransactions);
  });

  tearDown(() {
    transactionsCubit.close();
  });

  test('initial state should be TransactionsInitial', () {
    expect(transactionsCubit.state, equals(TransactionsInitial()));
  });

  group('getTransactions', () {
    final tTransactions = [
      Transaction(
        id: "1",
        name: 'name 1',
        merchant: 'merchant 1',
        billingAmount: 94,
        billingCurrency: "ILS",
        image: 'https://loremflickr.com/640/480/nature',
        date: DateTime.fromMillisecondsSinceEpoch(1736240779),
      ),
      Transaction(
        id: "2",
        name: 'name 2',
        merchant: 'merchant 2',
        billingAmount: 55,
        billingCurrency: "AED",
        image: 'https://loremflickr.com/640/480/nature',
        date: DateTime.fromMillisecondsSinceEpoch(1736240779),
      ),
    ];

    blocTest<TransactionsCubit, TransactionsState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTransactions()).thenAnswer((_) async => Right(tTransactions));
        return transactionsCubit;
      },
      act: (cubit) => cubit.getTransactionsList(),
      expect: () => [
        TransactionsLoading(),
        TransactionsLoaded(tTransactions),
      ],
    );

    blocTest<TransactionsCubit, TransactionsState>(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(mockGetTransactions()).thenAnswer((_) async => Left(ServerFailure()));
        return transactionsCubit;
      },
      act: (cubit) => cubit.getTransactionsList(),
      expect: () => [
        TransactionsLoading(),
        const TransactionsError('ServerFailure(Server Error)'),
      ],
    );
  });
}

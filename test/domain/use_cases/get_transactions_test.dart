import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:transactions_tracker/domain/entities/transaction.dart';
import 'package:transactions_tracker/domain/repositories/transaction_repository.dart';
import 'package:transactions_tracker/domain/use_cases/get_transactions.dart';

import 'get_transactions_test.mocks.dart';

@GenerateMocks([TransactionRepository])
void main() {
  late GetTransactions useCase;
  late MockTransactionRepository mockTransactionRepository;

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    useCase = GetTransactions(mockTransactionRepository);
  });

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

  test('should get transactions from the repository', () async {
    // arrange
    when(mockTransactionRepository.getTransactions()).thenAnswer((_) async => Right(tTransactions));

    // act
    final result = await useCase();

    // assert
    expect(result, Right(tTransactions));
    verify(mockTransactionRepository.getTransactions());
    verifyNoMoreInteractions(mockTransactionRepository);
  });
}

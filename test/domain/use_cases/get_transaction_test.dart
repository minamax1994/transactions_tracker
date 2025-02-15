import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:transactions_tracker/domain/entities/transaction.dart';
import 'package:transactions_tracker/domain/repositories/transaction_repository.dart';
import 'package:transactions_tracker/domain/use_cases/get_transaction.dart';

import 'get_transaction_test.mocks.dart';

@GenerateMocks([TransactionRepository])
void main() {
  late GetTransaction useCase;
  late MockTransactionRepository mockTransactionRepository;

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    useCase = GetTransaction(mockTransactionRepository);
  });

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

  test('should get transaction from the repository', () async {
    // arrange
    when(mockTransactionRepository.getTransactionById(tId)).thenAnswer((_) async => Right(tTransaction));

    // act
    final result = await useCase(tId);

    // assert
    expect(result, Right(tTransaction));
    verify(mockTransactionRepository.getTransactionById(tId));
    verifyNoMoreInteractions(mockTransactionRepository);
  });
}

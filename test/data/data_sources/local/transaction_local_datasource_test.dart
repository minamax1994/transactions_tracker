import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:transactions_tracker/data/data_sources/local/transaction_local_data_source.dart';
import 'package:transactions_tracker/data/models/transaction_model.dart';

import 'transaction_local_datasource_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late TransactionLocalDataSourceImpl dataSource;
  late MockBox<TransactionModel> mockBox;

  setUp(() {
    mockBox = MockBox<TransactionModel>();
    dataSource = TransactionLocalDataSourceImpl(transactionBox: mockBox);
  });

  group('getTransactions', () {
    final tTransactions = [
      TransactionModel(
        id: "1",
        name: 'name 1',
        merchant: 'merchant 1',
        billingAmount: 94,
        billingCurrency: "ILS",
        image: 'https://loremflickr.com/640/480/nature',
        date: DateTime.fromMillisecondsSinceEpoch(1736240779),
      ),
      TransactionModel(
        id: "2",
        name: 'name 2',
        merchant: 'merchant 2',
        billingAmount: 55,
        billingCurrency: "AED",
        image: 'https://loremflickr.com/640/480/nature',
        date: DateTime.fromMillisecondsSinceEpoch(1736240779),
      ),
    ];

    test('should return transactions when it exists in the cache', () async {
      when(mockBox.values).thenReturn(tTransactions);

      final result = await dataSource.getTransactions();

      verify(mockBox.values);
      expect(result, equals(tTransactions));
    });

    test('should throw Exception when transactions is not in cache', () async {
      when(mockBox.get(any)).thenReturn(null);

      final call = dataSource.getTransactions;

      expect(() => call(), throwsA(isA<Exception>()));
    });
  });

  group('cacheTransactions', () {
    final tTransactions = [
      TransactionModel(
        id: "1",
        name: 'name 1',
        merchant: 'merchant 1',
        billingAmount: 94,
        billingCurrency: "ILS",
        image: 'https://loremflickr.com/640/480/nature',
        date: DateTime.fromMillisecondsSinceEpoch(1736240779),
      ),
      TransactionModel(
        id: "2",
        name: 'name 2',
        merchant: 'merchant 2',
        billingAmount: 55,
        billingCurrency: "AED",
        image: 'https://loremflickr.com/640/480/nature',
        date: DateTime.fromMillisecondsSinceEpoch(1736240779),
      ),
    ];

    test('should cache the transactions', () async {
      when(mockBox.clear()).thenAnswer((_) async => 0);
      when(mockBox.putAll(any)).thenAnswer((_) async => {});

      await dataSource.cacheTransactions(tTransactions);

      verify(mockBox.putAll({for (var transaction in tTransactions) transaction.id: transaction}));
    });
  });

  group('getTransactionById', () {
    final tId = '1';
    final tTransaction = TransactionModel(
      id: tId,
      name: 'name 1',
      merchant: 'merchant 1',
      billingAmount: 94,
      billingCurrency: "ILS",
      image: 'https://loremflickr.com/640/480/nature',
      date: DateTime.fromMillisecondsSinceEpoch(1736240779),
    );

    test('should return transaction when it exists in the cache', () async {
      when(mockBox.get(any)).thenReturn(tTransaction);

      final result = await dataSource.getTransactionById(tId);

      verify(mockBox.get(tId));
      expect(result, equals(tTransaction));
    });

    test('should throw Exception when transaction is not in cache', () async {
      when(mockBox.get(any)).thenReturn(null);

      final call = dataSource.getTransactionById;

      expect(() => call(tId), throwsA(isA<Exception>()));
    });
  });

  group('cacheTransaction', () {
    final tTransaction = TransactionModel(
      id: '1',
      name: 'name 1',
      merchant: 'merchant 1',
      billingAmount: 94,
      billingCurrency: "ILS",
      image: 'https://loremflickr.com/640/480/nature',
      date: DateTime.fromMillisecondsSinceEpoch(1736240779),
    );

    test('should cache the transaction', () async {
      when(mockBox.put(any, any)).thenAnswer((_) async => {});

      await dataSource.cacheTransaction(tTransaction);

      verify(mockBox.put(tTransaction.id, tTransaction));
    });
  });
}

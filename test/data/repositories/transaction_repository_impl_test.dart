import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:transactions_tracker/core/error/failures.dart';
import 'package:transactions_tracker/data/data_sources/local/transaction_local_data_source.dart';
import 'package:transactions_tracker/data/data_sources/remote/transaction_remote_data_source.dart';
import 'package:transactions_tracker/data/models/transaction_model.dart';
import 'package:transactions_tracker/data/repositories/transaction_repository_impl.dart';
import 'package:transactions_tracker/domain/entities/transaction.dart';

import 'transaction_repository_impl_test.mocks.dart';

@GenerateMocks([TransactionRemoteDataSource, TransactionLocalDataSource, InternetConnectionChecker])
void main() {
  late TransactionRepositoryImpl repository;
  late MockTransactionRemoteDataSource mockRemoteDataSource;
  late MockTransactionLocalDataSource mockLocalDataSource;
  late MockInternetConnectionChecker mockConnectionChecker;

  setUp(() {
    mockRemoteDataSource = MockTransactionRemoteDataSource();
    mockLocalDataSource = MockTransactionLocalDataSource();
    mockConnectionChecker = MockInternetConnectionChecker();
    repository = TransactionRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      connectionChecker: mockConnectionChecker,
    );
  });

  group('getTransactions', () {
    final tTransactionsModel = [
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

    final List<Transaction> tTransactions = tTransactionsModel;

    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(mockConnectionChecker.hasConnection).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTransactions()).thenAnswer((_) async => tTransactionsModel);

      // act
      final result = await repository.getTransactions();

      // assert
      verify(mockRemoteDataSource.getTransactions());
      expect(result, equals(Right(tTransactions)));
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockConnectionChecker.hasConnection).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTransactions()).thenThrow(Exception());

      // act
      final result = await repository.getTransactions();

      // assert
      verify(mockRemoteDataSource.getTransactions());
      expect(result, equals(Left<Failure, Transaction>(ServerFailure('Exception'))));
    });
  });

  group('getTransactionById', () {
    final tId = '1';
    final tTransactionModel = TransactionModel(
      id: tId,
      name: 'name 1',
      merchant: 'merchant 1',
      billingAmount: 94,
      billingCurrency: "ILS",
      image: 'https://loremflickr.com/640/480/nature',
      date: DateTime.fromMillisecondsSinceEpoch(1736240779),
    );

    final Transaction tTransaction = tTransactionModel;

    test('should return remote data when the call to remote data source is successful', () async {
      // arrange
      when(mockConnectionChecker.hasConnection).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTransactionById(tId)).thenAnswer((_) async => tTransactionModel);

      // act
      final result = await repository.getTransactionById(tId);

      // assert
      verify(mockRemoteDataSource.getTransactionById(tId));
      expect(result, equals(Right(tTransaction)));
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockConnectionChecker.hasConnection).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTransactionById(tId)).thenThrow(Exception());

      // act
      final result = await repository.getTransactionById(tId);

      // assert
      verify(mockRemoteDataSource.getTransactionById(tId));
      expect(result, equals(Left<Failure, Transaction>(ServerFailure('Exception'))));
    });
  });
}

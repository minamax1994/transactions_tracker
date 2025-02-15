import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:transactions_tracker/data/data_sources/remote/transaction_remote_data_source.dart';
import 'package:transactions_tracker/data/models/transaction_model.dart';

import 'transaction_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late TransactionRemoteDataSource dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = TransactionRemoteDataSourceImpl(client: mockHttpClient);
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

    test('should return List<Transaction> when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(any, headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response('''
      [
        {
          "id": "1",
          "name": "name 1",
          "date": 1736240779,
          "merchant": "merchant 1",
          "billingAmount": 94,
          "image": "https://loremflickr.com/640/480/nature",
          "billingCurrency": "ILS"
        },
        {
          "id": "2",
          "name": "name 2",
          "date": 1736240779,
          "merchant": "merchant 2",
          "billingAmount": 55,
          "image": "https://loremflickr.com/640/480/nature",
          "billingCurrency": "AED"
        }
      ]
        ''', 200));

      // act
      final result = await dataSource.getTransactions();

      // assert
      expect(result, orderedEquals(tTransactionsModel));
    });

    test('should throw Exception when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.get(any, headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // act
      final call = dataSource.getTransactions();

      // assert
      expect(() => call, throwsException);
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

    test('should return Transaction when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(any, headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response('''{
          "id": "1",
          "name": "name 1",
          "date": 1736240779,
          "merchant": "merchant 1",
          "billingAmount": 94,
          "image": "https://loremflickr.com/640/480/nature",
          "billingCurrency": "ILS"
      }''', 200));

      // act
      final result = await dataSource.getTransactionById(tId);

      // assert
      expect(result, equals(tTransactionModel));
    });

    test('should return ServerFailure when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.get(any, headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // act
      final call = dataSource.getTransactionById(tId);

      // assert
      expect(() => call, throwsException);
    });
  });
}

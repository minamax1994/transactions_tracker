import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransactions();
  Future<TransactionModel> getTransactionById(String id);
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'https://677ab875671ca0306834b170.mockapi.io/pemo';

  TransactionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final response = await client.get(
      Uri.parse('$baseUrl/transaction'),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => TransactionModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  @override
  Future<TransactionModel> getTransactionById(String id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/transaction/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);

    if (response.statusCode == 200) {
      return TransactionModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load transaction');
    }
  }
}

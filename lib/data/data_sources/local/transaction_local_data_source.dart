import 'package:hive/hive.dart';

import '../../models/transaction_model.dart';

abstract class TransactionLocalDataSource {
  Future<List<TransactionModel>> getTransactions();
  Future<TransactionModel> getTransactionById(String id);
  Future<void> cacheTransactions(List<TransactionModel> transactions);
  Future<void> cacheTransaction(TransactionModel transaction);
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final Box<TransactionModel> transactionBox;

  TransactionLocalDataSourceImpl({required this.transactionBox});

  @override
  Future<List<TransactionModel>> getTransactions() async {
    try {
      final transactions = transactionBox.values.toList();
      if (transactions.isEmpty) {
        throw Exception('No cached transactions found');
      }
      return transactions;
    } catch (e) {
      throw Exception('Failed to get cached transactions');
    }
  }

  @override
  Future<TransactionModel> getTransactionById(String id) async {
    try {
      final transaction = transactionBox.get(id);
      if (transaction == null) {
        throw Exception('Transaction not found in cache');
      }
      return transaction;
    } catch (e) {
      throw Exception('Failed to get cached transaction');
    }
  }

  @override
  Future<void> cacheTransactions(List<TransactionModel> transactions) async {
    try {
      await transactionBox.clear();
      final transactionsMap = {for (var transaction in transactions) transaction.id: transaction};
      await transactionBox.putAll(transactionsMap);
    } catch (e) {
      throw Exception('Failed to cache transactions');
    }
  }

  @override
  Future<void> cacheTransaction(TransactionModel transaction) async {
    try {
      await transactionBox.put(transaction.id, transaction);
    } catch (e) {
      throw Exception('Failed to cache transaction');
    }
  }
}

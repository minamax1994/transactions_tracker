import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransactions {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  Future<Either<Failure, List<Transaction>>> call() async {
    return await repository.getTransactions();
  }
}

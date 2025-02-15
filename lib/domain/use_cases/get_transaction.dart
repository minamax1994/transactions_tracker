import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransaction {
  final TransactionRepository repository;

  GetTransaction(this.repository);

  Future<Either<Failure, Transaction>> call(String id) async {
    return await repository.getTransactionById(id);
  }
}

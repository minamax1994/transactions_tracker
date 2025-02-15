import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../data_sources/local/transaction_local_data_source.dart';
import '../data_sources/remote/transaction_remote_data_source.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;
  final TransactionLocalDataSource localDataSource;
  final InternetConnectionChecker connectionChecker;

  TransactionRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions() async {
    if (await connectionChecker.hasConnection) {
      try {
        final remoteTransactions = await remoteDataSource.getTransactions();
        await localDataSource.cacheTransactions(remoteTransactions);
        return Right(remoteTransactions);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        final localTransactions = await localDataSource.getTransactions();
        return Right(localTransactions);
      } catch (e) {
        return Left(CacheFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Transaction>> getTransactionById(String id) async {
    if (await connectionChecker.hasConnection) {
      try {
        final remoteTransaction = await remoteDataSource.getTransactionById(id);
        await localDataSource.cacheTransaction(remoteTransaction);
        return Right(remoteTransaction);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        final localTransaction = await localDataSource.getTransactionById(id);
        return Right(localTransaction);
      } catch (e) {
        return Left(CacheFailure(e.toString()));
      }
    }
  }
}

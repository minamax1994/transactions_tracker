import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/get_transactions.dart';
import 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final GetTransactions getTransactions;

  TransactionsCubit({required this.getTransactions}) : super(TransactionsInitial());

  Future<void> getTransactionsList() async {
    emit(TransactionsLoading());
    final result = await getTransactions();

    result.fold(
      (failure) => emit(TransactionsError(failure.toString())),
      (transactions) => emit(TransactionsLoaded(transactions)),
    );
  }
}

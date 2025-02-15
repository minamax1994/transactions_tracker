import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/get_transaction.dart';
import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final GetTransaction getTransaction;

  TransactionCubit({required this.getTransaction}) : super(TransactionInitial());

  Future<void> getTransactionDetails(String id) async {
    emit(TransactionLoading());
    final result = await getTransaction(id);

    result.fold(
      (failure) => emit(TransactionError(failure.toString())),
      (transaction) => emit(TransactionLoaded(transaction)),
    );
  }
}

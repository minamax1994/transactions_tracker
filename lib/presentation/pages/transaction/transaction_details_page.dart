import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/transaction/transaction_cubit.dart';
import '../../bloc/transaction/transaction_state.dart';

class TransactionDetailsPage extends StatefulWidget {
  final String transactionId;

  const TransactionDetailsPage({
    Key? key,
    required this.transactionId,
  }) : super(key: key);

  @override
  State<TransactionDetailsPage> createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  @override
  void initState() {
    context.read<TransactionCubit>().getTransactionDetails(widget.transactionId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
      ),
      body: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
            final transaction = state.transaction;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction ID: ${transaction.id}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Transaction Name: ${transaction.name}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Amount: \$${transaction.billingAmount.toStringAsFixed(2)} ${transaction.billingCurrency}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Merchant: ${transaction.merchant}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: ${transaction.date.toString().substring(0, 10)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          } else if (state is TransactionError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

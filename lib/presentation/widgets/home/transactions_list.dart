import 'package:flutter/material.dart';

import '../../../domain/entities/transaction.dart';
import '../../pages/transaction/transaction_details_page.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionsList({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          title: Text('\$${transaction.billingAmount.toStringAsFixed(2)} ${transaction.billingCurrency}'),
          subtitle: Text(transaction.name),
          trailing: Text(transaction.date.toString().substring(0, 10)),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TransactionDetailsPage(transactionId: transaction.id),
            ),
          ),
        );
      },
    );
  }
}

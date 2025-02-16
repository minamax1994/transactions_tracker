import 'package:flutter/cupertino.dart';
import 'package:transactions_tracker/presentation/widgets/common/transaction_item.dart';

import '../../../domain/entities/transaction.dart';
import '../../pages/transaction/transaction_details_page.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionsList({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return TransactionItem(
          transaction: transaction,
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(builder: (_) => TransactionDetailsPage(transactionId: transaction.id)),
          ),
        );
      },
    );
  }
}

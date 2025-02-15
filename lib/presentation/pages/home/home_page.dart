import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cards/cards_cubit.dart';
import '../../bloc/cards/cards_state.dart';
import '../../bloc/transactions/transactions_cubit.dart';
import '../../bloc/transactions/transactions_state.dart';
import '../../widgets/home/cards_list.dart';
import '../../widgets/home/transactions_list.dart';
import '../card_creation/card_creation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<CardsCubit>().getCardsList();
    context.read<TransactionsCubit>().getTransactionsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Cards',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              flex: 1,
              child: BlocBuilder<CardsCubit, CardsState>(
                builder: (context, state) {
                  if (state is CardsLoading) {
                    return Center(child: const CircularProgressIndicator());
                  } else if (state is CardsLoaded) {
                    return CardsList(cards: state.cards);
                  } else if (state is CardsError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Transactions',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              flex: 2,
              child: BlocBuilder<TransactionsCubit, TransactionsState>(
                builder: (context, state) {
                  if (state is TransactionsLoading) {
                    return Center(child: const CircularProgressIndicator());
                  } else if (state is TransactionsLoaded) {
                    return TransactionsList(transactions: state.transactions);
                  } else if (state is TransactionsError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CardCreationPage()),
        ),
        child: const Icon(Icons.add),
        tooltip: 'Add New Card',
      ),
    );
  }
}

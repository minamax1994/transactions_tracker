import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_tracker/domain/entities/card.dart';

import '../../bloc/cards/cards_cubit.dart';
import '../../bloc/cards/cards_state.dart';
import '../common/animated_card_item.dart';

class CardsList extends StatelessWidget {
  final List<CardEntity> cards;

  const CardsList({Key? key, required this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsCubit, CardsState>(
      builder: (context, state) {
        if (state is CardsLoaded) {
          if (state.cards.isEmpty) {
            return const Center(child: Text('No cards yet'));
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.cards.length,
            itemBuilder: (context, index) {
              final card = state.cards[index];
              return AnimatedCardItem(card: card);
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

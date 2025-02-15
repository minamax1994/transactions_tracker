import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/get_cards.dart';
import 'cards_state.dart';

class CardsCubit extends Cubit<CardsState> {
  final GetCards getCards;

  CardsCubit({required this.getCards}) : super(CardsInitial());

  Future<void> getCardsList() async {
    emit(CardsLoading());
    final result = await getCards();

    result.fold(
      (failure) => emit(CardsError(failure.toString())),
      (cards) => emit(CardsLoaded(cards)),
    );
  }
}

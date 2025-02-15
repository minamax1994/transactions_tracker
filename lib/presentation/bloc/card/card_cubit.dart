import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/create_card.dart';
import 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  final CreateCard createCard;

  CardCubit({required this.createCard}) : super(CardInitial());

  Future<void> createNewCard({
    required String name,
    required String cardholder,
    required int balance,
    required String color,
  }) async {
    emit(CardLoading());

    final params = CardParams(
      name: name,
      cardholder: cardholder,
      balance: balance,
      color: color,
    );

    final result = await createCard(params);

    result.fold(
      (failure) => emit(CardError(failure.toString())),
      (card) => emit(CardCreated(card)),
    );
  }
}

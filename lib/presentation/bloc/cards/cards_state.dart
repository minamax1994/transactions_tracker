import 'package:equatable/equatable.dart';

import '../../../domain/entities/card.dart';

abstract class CardsState extends Equatable {
  const CardsState();

  @override
  List<Object> get props => [];
}

class CardsInitial extends CardsState {}

class CardsLoading extends CardsState {}

class CardsLoaded extends CardsState {
  final List<CardEntity> cards;

  const CardsLoaded(this.cards);

  @override
  List<Object> get props => [cards];
}

class CardsError extends CardsState {
  final String message;

  const CardsError(this.message);

  @override
  List<Object> get props => [message];
}

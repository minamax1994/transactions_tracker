import 'package:equatable/equatable.dart';

import '../../../domain/entities/card.dart';

abstract class CardState extends Equatable {
  const CardState();

  @override
  List<Object> get props => [];
}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardCreated extends CardState {
  final CardEntity card;

  const CardCreated(this.card);

  @override
  List<Object> get props => [card];
}

class CardError extends CardState {
  final String message;

  const CardError(this.message);

  @override
  List<Object> get props => [message];
}

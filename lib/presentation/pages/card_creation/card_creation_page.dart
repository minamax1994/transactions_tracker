import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transactions_tracker/presentation/bloc/cards/cards_cubit.dart';

import '../../bloc/card/card_cubit.dart';
import '../../bloc/card/card_state.dart';
import '../../widgets/card_creation/steps/balance_step.dart';
import '../../widgets/card_creation/steps/color_step.dart';
import '../../widgets/card_creation/steps/name_step.dart';

class CardCreationPage extends StatefulWidget {
  const CardCreationPage({Key? key}) : super(key: key);

  @override
  State<CardCreationPage> createState() => _CardCreationPageState();
}

class _CardCreationPageState extends State<CardCreationPage> {
  final _formKeys = List.generate(3, (_) => GlobalKey<FormState>());
  int _currentStep = 0;

  String _cardName = '';
  String _cardholder = '';
  int _balance = 0;
  String _color = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Card'),
      ),
      body: BlocListener<CardCubit, CardState>(
        listener: (context, state) {
          if (state is CardCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Card created successfully!')),
            );
            context.read<CardsCubit>().getCardsList();
            Navigator.pop(context);
          } else if (state is CardError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (!_formKeys[_currentStep].currentState!.validate()) return;
            if (_currentStep < 2) {
              setState(() => _currentStep++);
            } else {
              _submitForm();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            }
          },
          steps: [
            Step(
              title: const Text('Card Details'),
              content: Form(
                key: _formKeys[0],
                child: NameStep(
                  onNameChanged: (value) => _cardName = value,
                  onCardholderChanged: (value) => _cardholder = value,
                ),
              ),
              isActive: _currentStep == 0,
            ),
            Step(
              title: const Text('Balance'),
              content: Form(
                key: _formKeys[1],
                child: BalanceStep(
                  onBalanceChanged: (value) => _balance = value,
                ),
              ),
              isActive: _currentStep == 1,
            ),
            Step(
              title: const Text('Color'),
              content: Form(
                key: _formKeys[2],
                child: ColorStep(
                  onColorChanged: (value) => _color = value,
                ),
              ),
              isActive: _currentStep == 2,
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() => context.read<CardCubit>().createNewCard(
        name: _cardName,
        cardholder: _cardholder,
        balance: _balance,
        color: _color,
      );
}

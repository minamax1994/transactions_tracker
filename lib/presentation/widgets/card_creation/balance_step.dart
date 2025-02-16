import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/app_text_form_field.dart';

class BalanceStep extends StatelessWidget {
  final Function(int) onBalanceChanged;

  const BalanceStep({
    Key? key,
    required this.onBalanceChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      hintText: 'Enter initial balance',
      prefixText: '\$ ',
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter balance';
        }
        final balance = int.tryParse(value);
        if (balance == null) {
          return 'Please enter a valid number';
        }
        if (balance < 100 || balance > 1000) {
          return 'Balance must be between 100 and 1000';
        }
        return null;
      },
      onChanged: (value) {
        final balance = int.tryParse(value) ?? 0;
        onBalanceChanged(balance);
      },
    );
  }
}

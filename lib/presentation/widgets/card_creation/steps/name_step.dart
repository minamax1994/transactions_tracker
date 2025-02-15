import 'package:flutter/material.dart';

class NameStep extends StatelessWidget {
  final Function(String) onNameChanged;
  final Function(String) onCardholderChanged;

  const NameStep({
    Key? key,
    required this.onNameChanged,
    required this.onCardholderChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Card Name',
            hintText: 'Enter card name',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter card name';
            }
            if (value.length < 3) {
              return 'Card name must be at least 3 characters';
            }
            if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
              return 'Only English characters are allowed';
            }
            return null;
          },
          onChanged: onNameChanged,
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Cardholder',
            hintText: 'Select cardholder',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter cardholder name';
            }
            return null;
          },
          onChanged: onCardholderChanged,
        ),
      ],
    );
  }
}

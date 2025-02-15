import 'package:flutter/material.dart';

class ColorStep extends StatefulWidget {
  final Function(String) onColorChanged;

  ColorStep({
    Key? key,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  State<ColorStep> createState() => _ColorStepState();
}

class _ColorStepState extends State<ColorStep> {
  String? groupValue;

  @override
  Widget build(BuildContext context) {
    final colors = {
      'Blue': '#2196F3',
      'Red': '#F44336',
      'Green': '#4CAF50',
      'Purple': '#9C27B0',
    };

    return FormField(
      validator: (value) {
        if (groupValue == null) {
          return 'Please select a color';
        }
        return null;
      },
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Card Color',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          ...colors.entries
              .map((entry) => RadioListTile(
                    key: Key("radio_list_tile_${entry.key.toLowerCase()}"),
                    title: Text(entry.value),
                    value: entry.value,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() => groupValue = value.toString());
                      widget.onColorChanged(value.toString());
                    },
                  ))
              .toList(),
          if (state.hasError) ...[
            const SizedBox(height: 8),
            Text(
              state.errorText.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ],
      ),
    );
  }
}

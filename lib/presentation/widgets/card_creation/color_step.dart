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
  String? selectedColor;

  final colors = {
    'Blue': '0xFF2196F3',
    'Red': '0xFFF44336',
    'Green': '0xFF4CAF50',
    'Purple': '0xFF9C27B0',
  };

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (value) {
        if (selectedColor == null) {
          return 'Please select a color';
        }
        return null;
      },
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Card Color',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          Row(
            spacing: 16,
            children: colors.entries.map((entry) {
              final isSelected = selectedColor == entry.value;
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
                duration: const Duration(milliseconds: 200),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: 1.0 + (0.1 * value),
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedColor = entry.value);
                        widget.onColorChanged(entry.value);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(int.parse(entry.value)),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Color(int.parse(entry.value)).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
                        ),
                        child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 32) : null,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          if (state.hasError) ...[
            const SizedBox(height: 16),
            Text(
              state.errorText!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
        ],
      ),
    );
  }
}

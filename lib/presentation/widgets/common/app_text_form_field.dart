import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? prefixText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AppTextFormField({
    Key? key,
    this.labelText,
    this.hintText,
    this.prefixText,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  InputBorder get border => OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[500]!),
        borderRadius: BorderRadius.circular(8),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        disabledBorder: border.copyWith(borderSide: BorderSide(color: Theme.of(context).disabledColor)),
        errorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red)),
        labelText: labelText,
        hintText: hintText,
        prefixText: prefixText,
        errorStyle: Theme.of(context).inputDecorationTheme.errorStyle?.copyWith(color: Colors.red),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: onChanged,
    );
  }
}

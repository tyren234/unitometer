import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericInput extends StatelessWidget {
  const NumericInput({super.key, required this.label, required this.onChanged});

  final String label;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*$")),
      ],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
    );
  }
}

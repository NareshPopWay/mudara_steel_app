import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RangeLimitingTextInputFormatter extends TextInputFormatter {
  final int minValue;
  final int maxValue;

  RangeLimitingTextInputFormatter({required this.minValue, required this.maxValue});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    if (newText.isEmpty) {
      return newValue; // Allow empty text
    }

    int parsedValue;
    try {
      parsedValue = int.parse(newText);
    } on FormatException {
      return oldValue; // Ignore invalid input
    }

    if (parsedValue < minValue) {
      return TextEditingValue().copyWith(text: minValue.toString()); // Clamp to minimum
    } else if (parsedValue > maxValue) {
      return TextEditingValue().copyWith(); // Clamp to maximum
    } else {
      return newValue; // Allow valid input within range
    }
  }
}
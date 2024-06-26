import 'package:flutter/material.dart';

class Validators {
  Validators._();
  static FormFieldValidator compare(
    TextEditingController? valueEditingController,
    String message,
  ) {
    return (value) {
      final valueCompare = valueEditingController?.text ?? '';
      if (value == null || (value != null && value != valueCompare)) {
        return message;
      }
      return null;
    };
  }
}

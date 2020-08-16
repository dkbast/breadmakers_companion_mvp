import 'package:flutter/material.dart';

class StyledInputNumberField extends StatelessWidget {
  final String label;
  final Function validator;
  final Function onSaved;

  const StyledInputNumberField(
      {@required this.label,
      this.validator: validateIsNumber,
      @required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15.0),
          border: UnderlineInputBorder(),
          fillColor: Colors.grey[200],
          filled: true,
          labelText: label),
      validator: validator,
      onSaved: onSaved,
      keyboardType: TextInputType.number,
    );
  }

  static String validateIsNumber(String value) {
    if (value == null || double.tryParse(value) == null) {
      return 'Please enter numbers only';
    }
    return null;
  }
}

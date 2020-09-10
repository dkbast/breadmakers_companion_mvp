import 'package:flutter/material.dart';

class StyledInputTextField extends StatelessWidget {
  final String label;
  final Function validator;
  final Function onSaved;
  final String initialValue;

  const StyledInputTextField(
      {@required this.label,
      this.validator: validateNotEmpty,
      @required this.onSaved,
      @required this.initialValue});

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
      initialValue: this.initialValue,
    );
  }

  static String validateNotEmpty(String value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }
}

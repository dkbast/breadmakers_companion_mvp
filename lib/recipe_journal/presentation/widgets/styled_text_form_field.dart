import 'package:flutter/material.dart';

class StyledInputTextField extends StatelessWidget {
  final String label;
  final Function validator;
  final Function onSaved;

  const StyledInputTextField(
      {@required this.label,
      this.validator: validateNotEmpty,
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
    );
  }

  static String validateNotEmpty(String value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }
}

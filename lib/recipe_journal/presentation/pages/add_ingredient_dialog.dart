import 'package:bmc_mvp/recipe_journal/data/models/ingredient.dart';
import 'package:bmc_mvp/recipe_journal/presentation/widgets/styled_number_form_field.dart';
import 'package:bmc_mvp/recipe_journal/presentation/widgets/styled_text_form_field.dart';
import 'package:flutter/material.dart';

class AddIngredientDialog {
  String _name;
  String _unit;
  double _amount;
  final Function saveIngredient;
  BuildContext context;
  static final List<String> valueList = [
    '',
    'g',
    'ml',
    'kg',
    'l',
  ];
  final _formKey = GlobalKey<FormState>();

  void saveName(String value) {
    this._name = value;
  }

  void saveUnit(String value) {
    this._unit = value;
  }

  void saveAmount(String value) {
    this._amount = double.tryParse(value);
  }

  AddIngredientDialog({this.saveIngredient});

  void call(BuildContext context) {
    this.context = context;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return buildDialog(context);
        });
  }

  Widget buildDialog(BuildContext context) {
    return Dialog(
        child: Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StyledInputTextField(
              label: 'Name of new ingredient', onSaved: saveName),
          StyledInputNumberField(label: 'Amount', onSaved: saveAmount),
          DropdownButtonFormField<String>(
            onSaved: saveUnit,
            onChanged: (String value) {
              //
            },
            value: 'g',
            items: valueList.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(value),
                ),
              );
            }).toList(),
          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                //Scaffold.of(this.context)
                //  .showSnackBar(SnackBar(content: Text('Adding ingredient')));
                _formKey.currentState.save();
                saveIngredient(
                    Ingredient(name: _name, amount: _amount, unit: _unit));
                Navigator.pop(context);
              }
            },
            child: Text('Save'),
          )
        ],
      ),
    ));
  }
}

import 'package:bmc_mvp/recipe_journal/data/models/ingredient.dart';
import 'package:bmc_mvp/recipe_journal/data/models/recipe.dart';
import 'package:bmc_mvp/recipe_journal/presentation/pages/add_ingredient_dialog.dart';
import 'package:bmc_mvp/recipe_journal/presentation/widgets/styled_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddRecipePage extends StatefulWidget {
  AddRecipePage({Key key}) : super(key: key);

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  AddIngredientDialog ingredientDialog;
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _description;
  List<Ingredient> _ingredients = [];

  @override
  Widget build(BuildContext context) {
    ingredientDialog = AddIngredientDialog(saveIngredient: saveIngredient);
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter new Recipe'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyledInputTextField(
                  onSaved: saveName, validator: validateName, label: 'Name '),
              SizedBox(height: 24.0),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      'A sour dough bread with pixie dust and unicorn milk',
                  labelText: 'Description',
                ),
                minLines: 3,
                maxLines: 7,
              ),
              Column(
                children: _ingredients.isNotEmpty
                    ? _ingredients.map((Ingredient ingredient) {
                        return ListTile(
                          leading: Text(ingredient.amount.toString() +
                              ' ' +
                              ingredient.unit),
                          title: Text(ingredient.name),
                          trailing: Icon(Icons.edit),
                        );
                      }).toList()
                    : [
                        ListTile(
                          leading: Text('100 ml'),
                          title: Text('Unicornmilk'),
                          trailing: IconButton(
                            icon: Icon(Icons.add),
                          ),
                          onTap: () {
                            ingredientDialog(context);
                          },
                        ),
                      ],
              ),
              RaisedButton(
                onPressed: () {
                  ingredientDialog(context);
                },
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    //Scaffold.of(context)
                    //  .showSnackBar(SnackBar(content: Text('Saving recipe')));
                    _formKey.currentState.save();
                    final Recipe newRecipe = Recipe(
                        name: _name,
                        description: _description,
                        imageUrl: '',
                        ingredients: _ingredients);
                    Box box = Hive.box('recipes');
                    box.add(newRecipe);
                  }
                },
                child: Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveName(String value) {
    this._name = value;
  }

  void saveDescription(String value) {
    this._description = value;
  }

  void saveIngredient(Ingredient ingredient) {
    setState(() {
      this._ingredients.add(ingredient);
    });
  }

  String validateName(value) {
    if (value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }
}

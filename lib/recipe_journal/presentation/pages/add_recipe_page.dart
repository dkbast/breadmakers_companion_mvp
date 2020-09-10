import 'dart:io';

import 'package:bmc_mvp/recipe_journal/data/models/ingredient.dart';
import 'package:bmc_mvp/recipe_journal/data/models/recipe.dart';
import 'package:bmc_mvp/recipe_journal/presentation/manager/CameraProvider.dart';
import 'package:bmc_mvp/recipe_journal/presentation/pages/add_ingredient_dialog.dart';
import 'package:bmc_mvp/recipe_journal/presentation/pages/take_picture_dialog.dart';
import 'package:bmc_mvp/recipe_journal/presentation/widgets/styled_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

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
  String _imagePath;
  List<Ingredient> _ingredients = [];

  @override
  Widget build(BuildContext context) {
    ingredientDialog = AddIngredientDialog(saveIngredient: saveIngredient);
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter new Recipe'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            //Scaffold.of(context)
            //  .showSnackBar(SnackBar(content: Text('Saving recipe')));
            _formKey.currentState.save();

            final _path = join(
              (await getApplicationDocumentsDirectory()).path,
              '${DateTime.now()}.png',
            );
            File(_imagePath).copySync(_path);

            final Recipe newRecipe = Recipe(
                name: _name,
                description: _description,
                imageUrl: _path,
                ingredients: _ingredients);
            Box box = Hive.box('recipes');
            box.add(newRecipe);
            Navigator.pop(context);
          }
        },
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
                onSaved: saveDescription,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      'A sour dough bread with pixie dust and unicorn milk',
                  labelText: 'Description',
                ),
                minLines: 3,
                maxLines: 7,
              ),
              _imagePath != null
                  ? Image.file(File(_imagePath))
                  : IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TakePictureDialog(
                                camera: Provider.of<CameraProvider>(context,
                                        listen: false)
                                    .camera,
                                saveImagePath: saveImage),
                          ),
                        );
                      },
                    ),
              Column(
                children: _ingredients.isNotEmpty
                    ? _ingredients.map((Ingredient ingredient) {
                        return ListTile(
                          leading: Text(ingredient.amount.toString() +
                              ' ' +
                              ingredient.unit),
                          title: Text(ingredient.name),
                          trailing: IconButton(
                              onPressed: () {
                                removeIngredient(ingredient);
                              },
                              splashRadius: 20.0,
                              icon: Icon(Icons.remove)),
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      ingredientDialog(context);
                    },
                  ),
                ),
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

  void saveImage(String imagePath) {
    setState(() {
      this._imagePath = imagePath;
    });
  }

  void removeIngredient(Ingredient ingredient) {
    setState(() {
      this._ingredients.remove(ingredient);
    });
  }

  String validateName(value) {
    if (value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }
}

import 'dart:io';

import 'package:bmc_mvp/recipe_journal/data/models/ingredient.dart';
import 'package:bmc_mvp/recipe_journal/data/models/recipe.dart';
import 'package:bmc_mvp/recipe_journal/presentation/pages/add_recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RecipeCard extends StatefulWidget {
  RecipeCard({@required this.recipe, @required this.index, Key key})
      : super(key: key);
  Recipe recipe;
  int index;

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    if (widget.recipe.name != null) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
        child: Text(
          widget.recipe.name,
          style: TextStyle(fontSize: 34.0),
        ),
      ));
    }
    if (widget.recipe.imageUrl != null) {
      widgets.add(Image.file(File(widget.recipe.imageUrl)));
    }
    if (widget.recipe.description != null) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(widget.recipe.description),
      ));
    }
    if (widget.recipe.ingredients.isNotEmpty) {
      widgets.add(Column(
          children: widget.recipe.ingredients.map((Ingredient ingredient) {
        return ListTile(
          leading: Text(ingredient.amount.toString() + ' ' + ingredient.unit),
          title: Text(ingredient.name),
        );
      }).toList()));
    }
    widgets.add(ButtonBar(
      children: [
        IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          icon: Icon(Icons.delete_forever),
          onPressed: () {
            // REFACTOR move to repository
            String imagePath = Hive.box('recipes').getAt(widget.index).imageUrl;
            if (imagePath != null) {
              File(imagePath).deleteSync();
            }
            Hive.box('recipes').deleteAt(widget.index);
          },
        ),
        IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddRecipePage(
                            recipeIndex: widget.index,
                          )));
            })
      ],
    ));
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }
}

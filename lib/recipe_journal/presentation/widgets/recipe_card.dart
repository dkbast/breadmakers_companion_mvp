import 'package:bmc_mvp/recipe_journal/data/models/ingredient.dart';
import 'package:bmc_mvp/recipe_journal/data/models/recipe.dart';
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
    ;
    widgets.add(IconButton(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      icon: Icon(Icons.delete_forever),
      onPressed: () {
        Hive.box('recipes').deleteAt(widget.index);
      },
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
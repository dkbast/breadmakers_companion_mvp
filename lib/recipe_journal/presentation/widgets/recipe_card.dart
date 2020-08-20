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
      widgets.add(Text(widget.recipe.name));
    }
    if (widget.recipe.description != null) {
      widgets.add(Text(widget.recipe.description));
    }
    widgets.add(IconButton(
      icon: Icon(Icons.delete_forever),
      onPressed: () {
        Hive.box('recipes').deleteAt(widget.index);
      },
    ));

    return Card(
      child: Column(
        children: widgets,
      ),
    );
  }
}

import 'package:bmc_mvp/recipe_journal/data/models/recipe.dart';
import 'package:bmc_mvp/recipe_journal/presentation/pages/add_recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListRecipiesPage extends StatefulWidget {
  ListRecipiesPage({Key key}) : super(key: key);

  @override
  _ListRecipiesPageState createState() => _ListRecipiesPageState();
}

class _ListRecipiesPageState extends State<ListRecipiesPage> {
  List<Recipe> recipes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box('recipes').listenable(),
        builder: (context, Box box, widget) {
          return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(box.getAt(index).name));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddRecipePage()));
        },
      ),
    );
  }
}

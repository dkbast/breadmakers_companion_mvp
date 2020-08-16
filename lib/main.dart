import 'package:bmc_mvp/recipe_journal/data/models/ingredient.dart';
import 'package:bmc_mvp/recipe_journal/presentation/pages/list_recipies_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'recipe_journal/data/models/recipe.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(IngredientAdapter());
  await Hive.openBox('recipes');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          body: ListRecipiesPage(),
        ));
  }
}

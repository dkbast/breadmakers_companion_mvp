import 'package:bmc_mvp/recipe_journal/data/models/ingredient.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Recipe extends Equatable {
  final String name;
  final String description;
  final String imageUrl;
  final List<Ingredient> ingredients;

  Recipe(
      {@required this.name,
      @required this.description,
      @required this.imageUrl,
      @required this.ingredients});

  factory Recipe.fromJson(Map<String, dynamic> jsonMap) {
    return Recipe(
        name: jsonMap['name'],
        description: jsonMap['description'],
        imageUrl: jsonMap['imageUrl'],
        ingredients: Ingredient.fromJsonList(jsonMap['ingredients']));
  }

  @override
  List<Object> get props => [name, description, imageUrl, ingredients];
}

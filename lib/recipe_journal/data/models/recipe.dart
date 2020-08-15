import 'package:bmc_mvp/recipe_journal/data/models/ingredient.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Recipe extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
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

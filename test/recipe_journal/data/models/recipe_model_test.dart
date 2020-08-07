import 'dart:convert';

import 'package:bmc_mvp/recipe_journal/domain/entities/ingredient.dart';
import 'package:bmc_mvp/recipe_journal/domain/entities/recipe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final RecipeModel tRecipeModel = RecipeModel(
      name: 'Bread',
      description: 'Bake it slowly',
      imageUrl: '',
      ingredients: [Ingredient(name: 'Flour', amount: 400, unit: 'g')]);

  test('should be subclass of Recipe', () {
    expect(tRecipeModel, isA<Recipe>());
  });

  group('fromJson', () {
    test('should return a valid model', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(FixtureReader('recipe.json'));
      // act
      final result = RecipeModel.fromJson(jsonMap);
      // assert
      expect(result, tRecipeModel);
    });
  });
}

class RecipeModel extends Recipe {
  RecipeModel(
      {@required String name,
      @required String description,
      @required String imageUrl,
      @required List<Ingredient> ingredients})
      : super(
            name: name,
            description: description,
            imageUrl: imageUrl,
            ingredients: ingredients);

  factory RecipeModel.fromJson(Map<String, dynamic> jsonMap) {
    return RecipeModel(
        name: jsonMap['name'],
        description: jsonMap['description'],
        imageUrl: jsonMap['imageUrl'],
        ingredients: IngredientModel.fromJsonList(jsonMap['ingredients']));
  }
}

import 'dart:convert';

import 'package:bmc_mvp/recipe_journal/data/models/ingredient.dart';
import 'package:bmc_mvp/recipe_journal/data/models/recipe.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final Recipe tRecipe = Recipe(
      name: 'Bread',
      description: 'Bake it slowly',
      imageUrl: '',
      ingredients: [Ingredient(name: 'Flour', amount: 100, unit: 'g')]);

  group('fromJson', () {
    test('should return a valid model', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(FixtureReader('recipe.json'));
      // act
      final result = Recipe.fromJson(jsonMap);
      // assert
      expect(result, tRecipe);
    });
  });
}

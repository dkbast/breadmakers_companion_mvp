import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import '../../../../lib/recipe_journal/data/models/ingredient.dart';
import '../../../fixtures/fixture_reader.dart';

void main() {
  Ingredient tIngredient;
  Ingredient tIngredient2;
  List<Ingredient> tIngredientList;
  setUp(() {
    tIngredient = Ingredient(name: 'Flour', amount: 100, unit: 'g');
    tIngredient2 = Ingredient(name: 'Flour', amount: 100, unit: 'g');
    tIngredientList = List();
    tIngredientList.add(tIngredient);
    tIngredientList.add(tIngredient2);
  });

  group('fromJson', () {
    test('should return a valid IngredientModel', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(FixtureReader('ingredient.json'));
      // act
      final result = Ingredient.fromJson(jsonMap);
      // assert
      expect(result, tIngredient);
    });
    test('should return a valid IngredientModel when amount is integer', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(FixtureReader('ingredient_integer.json'));
      // act
      final result = Ingredient.fromJson(jsonMap);
      // assert
      expect(result, tIngredient);
    });
  });

  group('fromJsonList', () {
    test('should return a list of IngredientModel when given a Json list', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(FixtureReader('ingredient_list.json'));
      // act
      final result = Ingredient.fromJsonList(jsonMap['ingredients']);
      // assert
      expect(result, tIngredientList);
    });
  });
}

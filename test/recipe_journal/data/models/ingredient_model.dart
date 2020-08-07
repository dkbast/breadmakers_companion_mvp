import 'dart:convert';

import 'package:bmc_mvp/recipe_journal/domain/entities/ingredient.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final IngredientModel tIngredientModel =
      new IngredientModel(name: 'Flour', amount: 100, unit: 'g');
  List<IngredientModel> tIngredientModelList = List();
  tIngredientModelList.add(tIngredientModel);

  test('should be subclass of Ingredient', () {
    expect(tIngredientModel, isA<Ingredient>());
  });

  group('fromJson', () {
    test('should return a valid IngredientModel', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(FixtureReader('ingredient.json'));
      // act
      final result = IngredientModel.fromJson(jsonMap);
      // assert
      expect(result, tIngredientModel);
    });
    test('should return a valid IngredientModel when amount is integer', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(FixtureReader('ingredient_integer.json'));
      // act
      final result = IngredientModel.fromJson(jsonMap);
      // assert
      expect(result, tIngredientModel);
    });
  });

  group('fromJsonList', () {
    test('should return a list of IngredientModel when given a Json list', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(FixtureReader('ingredient_list.json'));
      // act
      final result = IngredientModel.fromJsonList(jsonMap['ingredients']);
      // assert
      expect(result, tIngredientModelList);
    });
  });
}

class IngredientModel extends Ingredient {
  IngredientModel(
      {@required String name, @required double amount, @required String unit})
      : super(name: name, amount: amount, unit: unit);

  factory IngredientModel.fromJson(Map<String, dynamic> jsonMap) {
    return IngredientModel(
        name: jsonMap['name'],
        amount: (jsonMap['amount'] as num).toDouble(),
        unit: jsonMap['unit']);
  }

  static List<IngredientModel> fromJsonList(List<dynamic> jsonList) {
    List<IngredientModel> ingredientModelList =
        jsonList.map((entry) => IngredientModel.fromJson(entry)).toList();
    return ingredientModelList;
  }
}

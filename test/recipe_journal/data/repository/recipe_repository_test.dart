import 'package:bmc_mvp/recipe_journal/data/models/ingredient.dart';
import 'package:bmc_mvp/recipe_journal/data/models/recipe.dart';
import 'package:bmc_mvp/recipe_journal/data/repository/recipe_repository_impl.dart';
import 'package:bmc_mvp/recipe_journal/domain/repositories/recipe_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

class MockBox extends Mock implements Box<Recipe> {}

void main() {
  // get all recipes
  // persist new recipe

  RecipeRepository repository;
  Box<Recipe> tRecipeBox;

  final tRecipe = Recipe(
      name: 'Bread',
      description: 'Bake it slowly',
      imageUrl: '',
      ingredients: [Ingredient(name: 'Flour', amount: 400, unit: 'g')]);

  setUp(() {
    tRecipeBox = MockBox();
    repository = RecipeRepositoryImpl(recipeBox: tRecipeBox);
  });

  test('persist new recipe', () {
    // arrange
    when(tRecipeBox.add(any)).thenAnswer((_) => Future.value(1));
    // act
    repository.persistRecipe(tRecipe);
    // assert
    verify(tRecipeBox.add(tRecipe));
    verifyNoMoreInteractions(tRecipeBox);
  });
}

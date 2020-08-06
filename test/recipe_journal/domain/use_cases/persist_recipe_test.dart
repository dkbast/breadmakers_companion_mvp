import 'package:bmc_mvp/recipe_journal/domain/entities/ingredient.dart';
import 'package:bmc_mvp/recipe_journal/domain/entities/recipe.dart';
import 'package:bmc_mvp/recipe_journal/domain/repositories/recipe_repository.dart';
import 'package:bmc_mvp/recipe_journal/domain/use_cases/persist_recipe.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  MockRecipeRepository mockRecipeRepository;
  PersistRecipe usecase;
  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    usecase = PersistRecipe(recipeRepository: mockRecipeRepository);
  });

  final tRecipe = Recipe(
      name: 'Bread',
      description: 'Bake it slowly',
      imageUrl: '',
      ingredients: [Ingredient(name: 'Flour', amount: 400, unit: 'g')]);

  test('should pass a recipe object to the repository', () {
    // arrange
    when(mockRecipeRepository.persistRecipe(any));
    // act
    usecase(Params(recipe: tRecipe));
    // assert
    verify(mockRecipeRepository.persistRecipe(tRecipe));
    verifyNoMoreInteractions(mockRecipeRepository);
  });
}

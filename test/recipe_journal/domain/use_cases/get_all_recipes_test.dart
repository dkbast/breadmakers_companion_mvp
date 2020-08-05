import 'package:bmc_mvp/core/error/Failure.dart';
import 'package:bmc_mvp/core/usecases/usecase.dart';
import 'package:bmc_mvp/recipe_journal/domain/entities/ingredient.dart';
import 'package:bmc_mvp/recipe_journal/domain/entities/recipe.dart';
import 'package:bmc_mvp/recipe_journal/domain/repositories/recipe_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRecipeRepository extends Mock implements RecipeRepository {}

void Main() {
  MockRecipeRepository mockRecipeRepository;
  GetAllRecipes usecase;
  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    usecase = GetAllRecipes(recipeRepository: mockRecipeRepository);
  });

  final tRecipies = [
    Recipe(
        name: 'Bread',
        description: 'Bake it slowly',
        imageUrl: '',
        ingredients: [Ingredient(name: 'Flour', amount: 400, unit: 'g')])
  ];

  test('should get a list of all recipes', () async {
    // arrange
    when(mockRecipeRepository.getAllRecipes())
        .thenAnswer((_) async => Right(tRecipies));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tRecipies));
    verify(mockRecipeRepository.getAllRecipes());
    verifyNoMoreInteractions(mockRecipeRepository);
  });
}

class GetAllRecipes implements Usecase<List<Recipe>, NoParams> {
  RecipeRepository recipeRepository;

  GetAllRecipes({@required this.recipeRepository});

  @override
  Future<Either<Failure, List<Recipe>>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

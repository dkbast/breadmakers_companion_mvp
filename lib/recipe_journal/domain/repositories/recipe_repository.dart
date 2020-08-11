import 'package:bmc_mvp/core/error/failure.dart';
import 'package:bmc_mvp/recipe_journal/data/models/recipe.dart';
import 'package:dartz/dartz.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> getAllRecipes();
  void persistRecipe(Recipe recipe);
}

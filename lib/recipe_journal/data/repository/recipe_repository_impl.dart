import 'package:bmc_mvp/core/error/failure.dart';
import 'package:bmc_mvp/recipe_journal/data/models/recipe.dart';
import 'package:bmc_mvp/recipe_journal/domain/repositories/recipe_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  Box<Recipe> recipeBox;

  RecipeRepositoryImpl({@required this.recipeBox});

  @override
  Future<Either<Failure, List<Recipe>>> getAllRecipes() {
    // TODO: implement getAllRecipes
    throw UnimplementedError();
  }

  @override
  void persistRecipe(Recipe recipe) {
    assert(recipe != null);
    recipeBox.add(recipe);
  }
}

import 'package:bmc_mvp/core/error/failure.dart';
import 'package:bmc_mvp/core/usecases/usecase.dart';
import 'package:bmc_mvp/recipe_journal/domain/entities/recipe.dart';
import 'package:bmc_mvp/recipe_journal/domain/repositories/recipe_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class GetAllRecipes implements Usecase<List<Recipe>, NoParams> {
  final RecipeRepository recipeRepository;

  GetAllRecipes({@required this.recipeRepository});

  @override
  Future<Either<Failure, List<Recipe>>> call(NoParams params) async {
    return await recipeRepository.getAllRecipes();
  }
}

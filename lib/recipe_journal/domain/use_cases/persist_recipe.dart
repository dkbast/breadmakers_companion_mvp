import 'package:bmc_mvp/core/error/failure.dart';
import 'package:bmc_mvp/core/usecases/usecase.dart';
import 'package:bmc_mvp/recipe_journal/data/models/recipe.dart';
import 'package:bmc_mvp/recipe_journal/domain/repositories/recipe_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PersistRecipe implements Usecase<void, Params> {
  final RecipeRepository recipeRepository;
  PersistRecipe({@required this.recipeRepository});

  @override
  Future<Either<Failure, void>> call(params) {
    recipeRepository.persistRecipe(params.recipe);
  }
}

class Params extends Equatable {
  final Recipe recipe;

  Params({@required this.recipe});

  @override
  List<Object> get props => [recipe];
}

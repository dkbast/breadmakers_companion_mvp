import 'package:get_it/get_it.dart';

final sl = GetIt.instance();

Future<void> init() async {
  // sl.registerLazySingleton<RecipeRepository>(() => RecipeRepositoryImpl(recipeBox: recipeBox));
}

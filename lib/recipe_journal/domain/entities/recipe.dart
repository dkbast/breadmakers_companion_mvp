import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'ingredient.dart';

class Recipe extends Equatable {
  String name;
  String description;
  String imageUrl;
  List<Ingredient> ingredients;

  Recipe(
      {@required this.name,
      @required this.description,
      @required this.imageUrl,
      @required this.ingredients});

  @override
  List<Object> get props => [name, description, imageUrl, ingredients];
}

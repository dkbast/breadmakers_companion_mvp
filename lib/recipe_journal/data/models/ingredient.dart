import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Ingredient extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final String unit;

  Ingredient({@required this.name, @required this.amount, @required this.unit});

  @override
  List<Object> get props => [unit, amount, name];

  factory Ingredient.fromJson(Map<String, dynamic> jsonMap) {
    return Ingredient(
        name: jsonMap['name'],
        amount: (jsonMap['amount'] as num).toDouble(),
        unit: jsonMap['unit']);
  }

  static List<Ingredient> fromJsonList(List<dynamic> jsonList) {
    List<Ingredient> ingredientModelList =
        jsonList.map((entry) => Ingredient.fromJson(entry)).toList();
    return ingredientModelList;
  }
}

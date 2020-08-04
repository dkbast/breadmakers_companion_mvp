import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Ingredient extends Equatable {
  String name;
  double amount;
  String unit;

  Ingredient({@required name, @required amount, @required unit});

  @override
  List<Object> get props => [unit, amount, name];
}

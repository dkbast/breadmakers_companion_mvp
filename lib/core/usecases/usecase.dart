import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/Failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class UuidParams extends Equatable {
  final String uuid;

  UuidParams(this.uuid);

  @override
  List<Object> get props => [uuid];
}

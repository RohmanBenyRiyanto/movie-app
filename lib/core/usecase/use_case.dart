import 'package:dartz/dartz.dart';

import '../exceptions/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> execute(Params params);
}

// no param
abstract class UseCaseNoParam<Type> {
  Future<Either<Failure, Type>> execute();
}

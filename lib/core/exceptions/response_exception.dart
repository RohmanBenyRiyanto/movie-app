import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'failure.dart';

typedef F = Future<dynamic> Function();

@lazySingleton
class ResponseException {
  Future<Either<Failure, T>> exc<T>(F func) async {
    try {
      T remote = await func();
      return Right(remote);
    } catch (e) {
      return Left(
        Failure(
          e.toString().isEmpty ? "Something went wrong" : e.toString(),
        ),
      );
    }
  }
}

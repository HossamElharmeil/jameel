import 'package:dartz/dartz.dart';

import 'error/failures.dart';

abstract class UseCase<Success, Params> {

  Future<Either<Failure, Success>> call (Params params);
}

class NoParams{}
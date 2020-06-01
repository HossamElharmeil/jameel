import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

class GetCurrentUser extends UseCase<User, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  GetCurrentUser({@required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository;

  @override
  Future<Either<Failure, User>> call(NoParams noParams) async {
    return await _authenticationRepository.getCurrentUser();
  }
}

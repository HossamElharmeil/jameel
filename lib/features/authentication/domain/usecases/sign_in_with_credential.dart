import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/core/usecase.dart';
import 'package:jameel/features/authentication/domain/entities/user.dart';
import 'package:jameel/features/authentication/domain/repositories/authentication_repository.dart';

class SignInWithCredential extends UseCase<User, dynamic> {
  final AuthenticationRepository _authenticationRepository;

  SignInWithCredential(
      {@required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository;

  @override
  Future<Either<Failure, User>> call(credential) async {
    return await _authenticationRepository.signInWithCredential(credential);
  }
}

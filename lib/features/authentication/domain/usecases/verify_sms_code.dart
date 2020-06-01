import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

class VerifySmsCode extends UseCase<User, VerifySmsCodeParams> {
  final AuthenticationRepository _authenticationRepository;

  VerifySmsCode({@required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository;

  @override
  Future<Either<Failure, User>> call(params) async {
    return await _authenticationRepository.verifySmsCode(params);
  }
}

class VerifySmsCodeParams {
  final String verificationID;
  final String smsCode;

  VerifySmsCodeParams({this.verificationID, this.smsCode});
}

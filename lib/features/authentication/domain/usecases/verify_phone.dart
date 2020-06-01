import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

class VerifyPhone extends UseCase<User, VerifyPhoneParams> {
  final AuthenticationRepository _authenticationRepository;

  VerifyPhone({@required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository;

  @override
  Future<Either<Failure, User>> call(VerifyPhoneParams params) {
    return _authenticationRepository.verifyPhone(params);
  }
}

class VerifyPhoneParams {
  final String phoneNumber;
  final Duration timeout;
  final void Function(String) autoRetrievalTimeout;
  final void Function(dynamic authCredential) verificationCompleted;
  final void Function(dynamic authException) verificationFailed;
  final void Function(String, [int]) codeSent;

  VerifyPhoneParams({
    @required this.phoneNumber,
    @required this.timeout,
    @required this.autoRetrievalTimeout,
    @required this.verificationCompleted,
    @required this.verificationFailed,
    @required this.codeSent,
  });
}

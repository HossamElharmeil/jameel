import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../../../../core/util/email_and_password.dart';
import '../repositories/authentication_repository.dart';

class SignUpWithEmailAndPassword extends UseCase<bool, EmailAndPassword> {
  final AuthenticationRepository authenticationRepository;

  SignUpWithEmailAndPassword({@required this.authenticationRepository});
  @override
  Future<Either<Failure, bool>> call(EmailAndPassword params) {
    return authenticationRepository.signUpWithEmailAndPassword(
        params.email, params.password);
  }
}

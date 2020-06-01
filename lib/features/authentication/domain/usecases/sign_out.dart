import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../repositories/authentication_repository.dart';

class SignOut extends UseCase<bool, NoParams> {
  final AuthenticationRepository authenticationRepository;

  SignOut({@required this.authenticationRepository});
  @override
  Future<Either<Failure, bool>> call(NoParams noParams) async {
    return await authenticationRepository.signOut();
  }
}

class NoParams {}

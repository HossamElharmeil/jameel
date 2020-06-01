import 'package:dartz/dartz.dart';
import 'package:jameel/features/authentication/domain/usecases/verify_sms_code.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../domain/usecases/verify_phone.dart';
import '../data_sources/authentication_service.dart';

const AUTHENTICATION_FAILURE = "Authentication failed";

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationService _authenticationService;

  AuthenticationRepositoryImpl({@required AuthenticationService authenticationService})
      : assert(authenticationService != null),
        _authenticationService = authenticationService;

  @override
  Future<Either<Failure, bool>> signInWithEmailAndPassword(
      String email, String password) {
    try {
      _authenticationService.signInWithEmailAndPassword(email, password);
      return Future.value(Right(true));
    } catch (_) {
      return Future.value(Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
    }
  }

  @override
  Future<Either<Failure, bool>> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      await _authenticationService.signUpWithEmailAndPassword(email, password);
      return Future.value(Right(true));
    } catch (_) {
      return Future.value(Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      await _authenticationService.signOut();
      return Future.value(Right(true));
    } catch (_) {
      return Left(AuthenticationFailure(AUTHENTICATION_FAILURE));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      return Right(await _authenticationService.getCurrentUser());
    } catch (_) {
      return Left(AuthenticationFailure(AUTHENTICATION_FAILURE));
    }
  }

  @override
  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      return Right(await _authenticationService.isSignedIn());
    } catch (_) {
      return Left(AuthenticationFailure(AUTHENTICATION_FAILURE));
    }
  }

  @override
  Future<Either<Failure, User>> verifyPhone(VerifyPhoneParams params) async {
    try {
      return Right(await _authenticationService.verifyPhone(params));
    } catch (_) {
      return Left(AuthenticationFailure(AUTHENTICATION_FAILURE));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithCredential(credential) async {
    try {
      return Right(
          await _authenticationService.signInWithCredential(credential));
    } catch (_) {
      return Left(AuthenticationFailure(AUTHENTICATION_FAILURE));
    }
  }

  @override
  Future<Either<Failure, User>> verifySmsCode(
      VerifySmsCodeParams params) async {
    try {
      return Right(await _authenticationService.verifySmsCode(params));
    } catch (_) {
      return Left(AuthenticationFailure(AUTHENTICATION_FAILURE));
    }
  }
}

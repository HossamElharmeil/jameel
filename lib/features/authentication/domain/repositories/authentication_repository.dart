import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:jameel/features/authentication/domain/usecases/verify_sms_code.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../usecases/verify_phone.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, bool>> signUpWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, bool>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, bool>> signOut();
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, bool>> isSignedIn();
  Future<Either<Failure, User>> verifyPhone(VerifyPhoneParams params);
  Future<Either<Failure, User>> verifySmsCode(VerifySmsCodeParams params);
  Future<Either<Failure, User>> signInWithCredential(dynamic credential);
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/authentication/domain/entities/user.dart';
import 'package:jameel/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:jameel/features/authentication/domain/usecases/sign_in_with_credential.dart';
import 'package:jameel/features/authentication/domain/usecases/verify_phone.dart';
import 'package:mockito/mockito.dart';

const AUTHENTICATION_FAILURE = 'Authentication unsuccessful';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockVerifyPhoneParams extends Mock implements VerifyPhoneParams {}

void main() {
  SignInWithCredential signInWithCredential;
  AuthenticationRepository mockAuthenticationRepository;
  User tUser;
  dynamic credential;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    signInWithCredential = SignInWithCredential(
        authenticationRepository: mockAuthenticationRepository);
    tUser = User(
        userID: 'test userID',
        displayName: 'test name',
        phoneNumber: '123456789',
        email: 'test@email.com');
  });

  test(
    'should forward the call to the authentication repository and return the result',
    () async {
      when(mockAuthenticationRepository.signInWithCredential(any))
          .thenAnswer((_) async => Right(tUser));

      final result = await signInWithCredential(credential);

      verify(mockAuthenticationRepository.signInWithCredential(credential));
      expect(result, Right(tUser));
    },
  );

  test(
    'should return a left containing a failure when the repository returns the same',
    () async {
      when(mockAuthenticationRepository.signInWithCredential(any)).thenAnswer(
          (_) async => Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));

      final result = await signInWithCredential(credential);

      verify(mockAuthenticationRepository.signInWithCredential(credential));
      expect(result, Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
    },
  );
}

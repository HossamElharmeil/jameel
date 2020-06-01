import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/authentication/domain/entities/user.dart';
import 'package:jameel/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:jameel/features/authentication/domain/usecases/verify_sms_code.dart';
import 'package:mockito/mockito.dart';

const AUTHENTICATION_FAILURE = 'Authentication unsuccessful';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockVerifySmsCodeParams extends Mock implements VerifySmsCodeParams {}

void main() {
  VerifySmsCode verifySmsCode;
  AuthenticationRepository mockAuthenticationRepository;
  User tUser;
  VerifySmsCodeParams params;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    verifySmsCode =
        VerifySmsCode(authenticationRepository: mockAuthenticationRepository);
    tUser = User(
        userID: 'test userID',
        displayName: 'test name',
        phoneNumber: '123456789',
        email: 'test@email.com');
    params = MockVerifySmsCodeParams();
  });

  test(
    'should forward the call to the authentication repository and return the result',
    () async {
      when(mockAuthenticationRepository.verifySmsCode(any))
          .thenAnswer((_) async => Right(tUser));

      final result = await verifySmsCode(params);

      verify(mockAuthenticationRepository.verifySmsCode(params));
      expect(result, Right(tUser));
    },
  );

  test(
    'should return a left containing a failure when the repository returns the same',
    () async {
      when(mockAuthenticationRepository.verifySmsCode(any))
          .thenAnswer((_) async => Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));

      final result = await verifySmsCode(params);

      verify(mockAuthenticationRepository.verifySmsCode(params));
      expect(result, Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
    },
  );
}

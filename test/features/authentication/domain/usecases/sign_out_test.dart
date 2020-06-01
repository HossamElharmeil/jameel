import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:jameel/features/authentication/domain/usecases/sign_out.dart';
import 'package:mockito/mockito.dart';

const AUTHENTICATION_FAILURE = 'Authentication failed';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  AuthenticationRepository authenticationRepository;
  SignOut signOut;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
    signOut = SignOut(authenticationRepository: authenticationRepository);
  });

  test(
      'should forward the call to the repository when the call method is called and return the result',
      () async {
    when(authenticationRepository.signOut())
        .thenAnswer((_) async => Right(true));

    final result = await signOut(NoParams());

    verify(authenticationRepository.signOut());
    expect(result, Right(true));
  });

  test(
      'should return a left containing authentication failure when the call to the repository returns left',
      () async {
    when(authenticationRepository.signOut()).thenAnswer(
        (_) async => Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));

    final result = await signOut(NoParams());

    verify(authenticationRepository.signOut());
    expect(result, Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
  });
}

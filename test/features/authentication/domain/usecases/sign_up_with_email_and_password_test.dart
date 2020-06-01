import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/core/util/email_and_password.dart';
import 'package:jameel/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:jameel/features/authentication/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:mockito/mockito.dart';

const AUTHENTICATION_FAILURE = "Authentication failed";

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  AuthenticationRepository mockAuthenticationRepository;
  SignUpWithEmailAndPassword signUpWithEmailAndPassword;
  EmailAndPassword emailAndPassword;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    emailAndPassword = EmailAndPassword(
        email: 'hossam.elharmil@gmail.com', password: 'Test12345');
    signUpWithEmailAndPassword = SignUpWithEmailAndPassword(
        authenticationRepository: mockAuthenticationRepository);
  });

  test("should forward the call to AuthenticationRepository", () {
    signUpWithEmailAndPassword(emailAndPassword);

    verify(mockAuthenticationRepository.signUpWithEmailAndPassword(
        emailAndPassword.email, emailAndPassword.password));
  });

  test(
      "should return right of either with true when the repository signs up successfully",
      () async {
    when(mockAuthenticationRepository.signUpWithEmailAndPassword(any, any))
        .thenAnswer((_) async => Right(true));

    final result = await signUpWithEmailAndPassword(emailAndPassword);

    verify(mockAuthenticationRepository.signUpWithEmailAndPassword(
        emailAndPassword.email, emailAndPassword.password));
    expect(result, Right(true));
  });

  test(
      "should return Left of either with a failure when the authenticationrepository fails the registration",
      () async {
    when(mockAuthenticationRepository.signUpWithEmailAndPassword(any, any))
        .thenAnswer((_) async => Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));

    final result = await signUpWithEmailAndPassword(emailAndPassword);

    verify(mockAuthenticationRepository.signUpWithEmailAndPassword(
        emailAndPassword.email, emailAndPassword.password));
    expect(result, Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/core/util/email_and_password.dart';
import 'package:jameel/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:jameel/features/authentication/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:mockito/mockito.dart';

const AUTHENTICATION_FAILURE = "Authentication failed";

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  AuthenticationRepository mockAuthenticationRepository;
  SignInWithEmailAndPassword signInWithEmailAndPassword;
  EmailAndPassword emailAndPassword;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    emailAndPassword = EmailAndPassword(
        email: 'hossam.elharmil@gmail.com', password: 'Test12345');
    signInWithEmailAndPassword = SignInWithEmailAndPassword(
        authenticationRepository: mockAuthenticationRepository);
  });

  test("should forward the call to AuthenticationRepository", () {
    signInWithEmailAndPassword(emailAndPassword);

    verify(mockAuthenticationRepository.signInWithEmailAndPassword(
        emailAndPassword.email, emailAndPassword.password));
  });

  test(
      "should return right of either with true when the repository signs up successfully",
      () async {
    when(mockAuthenticationRepository.signInWithEmailAndPassword(any, any))
        .thenAnswer((_) async => Right(true));

    final result = await signInWithEmailAndPassword(emailAndPassword);

    verify(mockAuthenticationRepository.signInWithEmailAndPassword(
        emailAndPassword.email, emailAndPassword.password));
    expect(result, Right(true));
  });

  test(
      "should return Left of either with a failure when the authenticationrepository fails the registration",
      () async {
    when(mockAuthenticationRepository.signInWithEmailAndPassword(any, any))
        .thenAnswer((_) async => Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));

    final result = await signInWithEmailAndPassword(emailAndPassword);

    verify(mockAuthenticationRepository.signInWithEmailAndPassword(
        emailAndPassword.email, emailAndPassword.password));
    expect(result, Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
  });
}

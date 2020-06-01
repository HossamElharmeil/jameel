import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/exceptions.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/core/util/email_and_password.dart';
import 'package:jameel/features/authentication/data/data_sources/authentication_service.dart';
import 'package:jameel/features/authentication/data/repositories/athentication_repository_impl.dart';
import 'package:jameel/features/authentication/domain/entities/user.dart';
import 'package:jameel/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:jameel/features/authentication/domain/usecases/verify_phone.dart';
import 'package:jameel/features/authentication/domain/usecases/verify_sms_code.dart';
import 'package:mockito/mockito.dart';

const AUTHENTICATION_FAILURE = "Authentication failed";

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockVerifyPhoneParams extends Mock implements VerifyPhoneParams {}

class MockVerifySmsCodeParams extends Mock implements VerifySmsCodeParams {}

void main() {
  AuthenticationService mockAuthenticationService;
  AuthenticationRepository authenticationRepository;
  EmailAndPassword emailAndPassword;
  User user;
  VerifyPhoneParams verifyPhoneParams;
  VerifySmsCodeParams verifySmsCodeParams;

  setUp(
    () {
      mockAuthenticationService = MockAuthenticationService();
      authenticationRepository = AuthenticationRepositoryImpl(
          authenticationService: mockAuthenticationService);
      emailAndPassword = EmailAndPassword(
          email: 'hossam.elharmil@gmail.com', password: 'Test12345');
      user = User(
        userID: 'test userID',
        displayName: 'test name',
        phoneNumber: '123456789',
        email: 'test@email.com',
      );
      verifyPhoneParams = MockVerifyPhoneParams();
      verifySmsCodeParams = MockVerifySmsCodeParams();
    },
  );

  group('SignUp repository test', () {
    test(
        'should forward the call to the authentication service when signup with email and password and return true if the call is successful',
        () async {
      when(mockAuthenticationService.signUpWithEmailAndPassword(any, any))
          .thenAnswer((_) async => null);

      final result = await authenticationRepository.signUpWithEmailAndPassword(
          emailAndPassword.email, emailAndPassword.password);

      verify(mockAuthenticationService.signUpWithEmailAndPassword(
          emailAndPassword.email, emailAndPassword.password));
      expect(result, Right(true));
    });

    test(
        'should forward the call to authentication service and return authentication failure if the call is unsuccessful',
        () async {
      when(mockAuthenticationService.signUpWithEmailAndPassword(any, any))
          .thenThrow(AuthenticationException());

      final result = await authenticationRepository.signUpWithEmailAndPassword(
          emailAndPassword.email, emailAndPassword.password);

      expect(result, Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
    });
  });

  group('SignIn repository test', () {
    test(
        'should forward the call to the authentication service when signup with email and password and return true if the call is successful',
        () async {
      when(mockAuthenticationService.signInWithEmailAndPassword(any, any))
          .thenAnswer((_) async => null);

      final result = await authenticationRepository.signInWithEmailAndPassword(
          emailAndPassword.email, emailAndPassword.password);

      verify(mockAuthenticationService.signInWithEmailAndPassword(
          emailAndPassword.email, emailAndPassword.password));
      expect(result, Right(true));
    });

    test(
        'should forward the call to authentication service and return authentication failure if the call is unsuccessful',
        () async {
      when(mockAuthenticationService.signInWithEmailAndPassword(any, any))
          .thenThrow(AuthenticationException());

      final result = await authenticationRepository.signInWithEmailAndPassword(
          emailAndPassword.email, emailAndPassword.password);

      expect(result, Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
    });
  });

  group('SignOut test', () {
    test(
        'should forward the call to the authentication service to sign the user out and return the result',
        () async {
      when(mockAuthenticationService.signOut()).thenAnswer((_) async => null);

      final result = await authenticationRepository.signOut();

      verify(mockAuthenticationService.signOut());
      expect(result, Right(true));
    });

    test(
        'should return a left containing authentication failure when the call to the authentication service is unsuccessful',
        () async {
      when(mockAuthenticationService.signOut())
          .thenThrow(AuthenticationException());

      final result = await authenticationRepository.signOut();

      expect(result, Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
    });
  });

  group('getCUrrentUser test', () {
    test(
        'should forward the call to the authentication service and return the result when getCurrentUser is called',
        () async {
      when(mockAuthenticationService.getCurrentUser())
          .thenAnswer((_) async => user);

      final result = await authenticationRepository.getCurrentUser();

      verify(mockAuthenticationService.getCurrentUser());
      expect(result, Right(user));
    });

    test(
        'should return a left containing authentication failure when the call to authentication service is unsuccessful',
        () async {
      when(mockAuthenticationService.getCurrentUser())
          .thenThrow(AuthenticationException);

      final result = await authenticationRepository.getCurrentUser();

      verify(mockAuthenticationService.getCurrentUser());
      expect(result, Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
    });
  });

  group('isSignedIn test', () {
    test(
        'should forward the call to the authentication service and return the result when isSignedIn is called',
        () async {
      when(mockAuthenticationService.isSignedIn())
          .thenAnswer((_) async => true);

      final result = await authenticationRepository.isSignedIn();

      verify(mockAuthenticationService.isSignedIn());
      expect(result, Right(true));
    });

    test(
        'should return a left containing authentication failure when the call to authentication service is unsuccessful',
        () async {
      when(mockAuthenticationService.isSignedIn())
          .thenThrow(AuthenticationException);

      final result = await authenticationRepository.isSignedIn();

      verify(mockAuthenticationService.isSignedIn());
      expect(result, Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
    });
  });

  group(
    'Verify phone test',
    () {
      test(
          'should forward the call to the authentication service and return right containing the result',
          () async {
        when(mockAuthenticationService.verifyPhone(any))
            .thenAnswer((_) async => user);

        final result =
            await authenticationRepository.verifyPhone(verifyPhoneParams);

        verify(mockAuthenticationService.verifyPhone(verifyPhoneParams));
        expect(result, Right(user));
      });

      test(
          'should return a left containing failure if the authentication service throws an exception',
          () async {
        when(mockAuthenticationService.verifyPhone(any))
            .thenThrow(AuthenticationException);

        final result =
            await authenticationRepository.verifyPhone(verifyPhoneParams);

        verify(mockAuthenticationService.verifyPhone(verifyPhoneParams));
        expect(result, Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
      });
    },
  );

  group(
    'SignInWithCredential test',
    () {
      test(
          'should forward the call to the authentication service and return right containing the result',
          () async {
        when(mockAuthenticationService.signInWithCredential(any))
            .thenAnswer((_) async => user);

        final result = await authenticationRepository
            .signInWithCredential(verifyPhoneParams);

        verify(
            mockAuthenticationService.signInWithCredential(verifyPhoneParams));
        expect(result, Right(user));
      });

      test(
          'should return a left containing failure if the authentication service throws an exception',
          () async {
        when(mockAuthenticationService.signInWithCredential(any))
            .thenThrow(AuthenticationException);

        final result = await authenticationRepository
            .signInWithCredential(verifyPhoneParams);

        verify(
            mockAuthenticationService.signInWithCredential(verifyPhoneParams));
        expect(result, Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
      });
    },
  );

  group(
    'VerifySmsCode test',
    () {
      test(
          'should forward the call to the authentication service and return right containing the result',
          () async {
        when(mockAuthenticationService.verifySmsCode(any))
            .thenAnswer((_) async => user);

        final result =
            await authenticationRepository.verifySmsCode(verifySmsCodeParams);

        verify(mockAuthenticationService.verifySmsCode(verifySmsCodeParams));
        expect(result, Right(user));
      });

      test(
          'should return a left containing failure if the authentication service throws an exception',
          () async {
        when(mockAuthenticationService.verifySmsCode(any))
            .thenThrow(AuthenticationException);

        final result =
            await authenticationRepository.verifySmsCode(verifySmsCodeParams);

        verify(mockAuthenticationService.verifySmsCode(verifySmsCodeParams));
        expect(result, Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
      });
    },
  );
}

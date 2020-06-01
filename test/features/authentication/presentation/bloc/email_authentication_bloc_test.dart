import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:jameel/core/util/email_and_password.dart';
import 'package:jameel/features/authentication/data/models/user_model.dart';
import 'package:jameel/features/authentication/data/repositories/athentication_repository_impl.dart';
import 'package:jameel/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:jameel/features/authentication/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:jameel/features/authentication/domain/usecases/sign_out.dart';
import 'package:jameel/features/authentication/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:jameel/features/authentication/presentation/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:jameel/core/error/failures.dart';

const AUTHENTICATION_FAILURE = "Authentication Unsuccessful";

class MockSignInWithEmailAndPassword extends Mock
    implements SignInWithEmailAndPassword {}

class MockSignUpWithEmailAndPassword extends Mock
    implements SignUpWithEmailAndPassword {}

class MockSignOut extends Mock implements SignOut {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepositoryImpl {}

void main() {
  SignInWithEmailAndPassword mockSignInWithEmailAndPassword;
  SignUpWithEmailAndPassword mockSignUpWithEmailAndPassword;
  SignOut mockSignOut;
  AuthenticationRepository authenticationRepository;
  EmailAuthenticationBloc authenticationBloc;

  setUp(() {
    mockSignInWithEmailAndPassword = MockSignInWithEmailAndPassword();
    mockSignUpWithEmailAndPassword = MockSignUpWithEmailAndPassword();
    mockSignOut = MockSignOut();
    authenticationRepository = MockAuthenticationRepository();
    authenticationBloc = EmailAuthenticationBloc(
      signInWithEmailAndPassword: mockSignInWithEmailAndPassword,
      signUpWithEmailAndPassword: mockSignUpWithEmailAndPassword,
      signOut: mockSignOut,
      repository: authenticationRepository,
    );
  });
  group('authentication bloc test', () {
    blocTest(
      'should emit initial state when constructed',
      build: () {
        return authenticationBloc;
      },
      expect: [EmailAuthenticationInitial()],
    );

    group(
      'Sign up bloc test',
      () {
        blocTest(
          'should return EmailAuthenticationRequestFailure when the sign up use case returns a left',
          build: () {
            when(mockSignUpWithEmailAndPassword(any)).thenAnswer((_) async =>
                Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
            return authenticationBloc;
          },
          act: (bloc) async {
            await bloc.add(SignedUp(EmailAndPassword(
                email: 'email@email.com', password: 'password')));
          },
          expect: [
            EmailAuthenticationInitial(),
            EmailAuthenticationRequestInProgress(),
            EmailAuthenticationRequestFailure(
                AuthenticationFailure(AUTHENTICATION_FAILURE)),
          ],
        );
        blocTest(
          'should emit initial then authenticating then AuthenticationSuccess when SignedUp event is added and the usecase returns a right containing true',
          build: () {
            when(mockSignUpWithEmailAndPassword(any))
                .thenAnswer((_) async => Right(true));
            when(authenticationRepository.getCurrentUser()).thenAnswer(
              (_) async => Right(
                UserModel(
                  email: 'email@gmail.com',
                  phoneNumber: '123456689',
                  displayName: 'display name',
                  userID: '12345',
                ),
              ),
            );

            return authenticationBloc;
          },
          act: (bloc) async {
            bloc.add(SignedUp(EmailAndPassword(
                email: 'hossam.elharmil@gmail.com', password: 'Test12345')));
          },
          expect: [
            EmailAuthenticationInitial(),
            EmailAuthenticationRequestInProgress(),
            EmailAuthenticationRequestSuccess(
              UserModel(
                email: 'email@gmail.com',
                phoneNumber: '123456689',
                displayName: 'display name',
                userID: '12345',
              ),
            ),
          ],
        );

        blocTest(
          'should emit initial then authenticating then AuthenticationFailure when SignedUp event is added and the usecase returns a left containing failure',
          build: () {
            when(mockSignUpWithEmailAndPassword(any)).thenAnswer((_) async =>
                Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
            when(authenticationRepository.getCurrentUser()).thenAnswer(
                (_) async =>
                    Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
            return authenticationBloc;
          },
          act: (bloc) async {
            bloc.add(SignedUp(EmailAndPassword(
                email: 'hossam.elharmil@gmail.com', password: 'Test12345')));
          },
          expect: [
            EmailAuthenticationInitial(),
            EmailAuthenticationRequestInProgress(),
            EmailAuthenticationRequestFailure(
                AuthenticationFailure(AUTHENTICATION_FAILURE)),
          ],
        );
      },
    );

    group('Sign in bloc test', () {
      blocTest(
        'should emit EmailAuthenticationRequestFailure when SignIn usecase returns a left containing failure',
        build: () {
          when(mockSignInWithEmailAndPassword(any)).thenAnswer(
              (_) async => Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
          return authenticationBloc;
        },
        act: (bloc) async {
          bloc.add(SignedIn(EmailAndPassword(
              email: 'email@email.com', password: 'password')));
        },
        expect: [
          EmailAuthenticationInitial(),
          EmailAuthenticationRequestInProgress(),
          EmailAuthenticationRequestFailure(
              AuthenticationFailure(AUTHENTICATION_FAILURE)),
        ],
      );

      blocTest(
        'should emit initial then authenticating then AuthenticationSuccess when signedIn event is added and the usecase returns a right containing true',
        build: () {
          when(mockSignInWithEmailAndPassword(any))
              .thenAnswer((_) async => Right(true));
          when(authenticationRepository.getCurrentUser())
              .thenAnswer((_) async => Right(
                    UserModel(
                      email: 'email@gmail.com',
                      phoneNumber: '123456689',
                      displayName: 'display name',
                      userID: '12345',
                    ),
                  ));
          return authenticationBloc;
        },
        act: (bloc) async {
          bloc.add(SignedIn(EmailAndPassword(
              email: 'hossam.elharmil@gmail.com', password: 'Test12345')));
        },
        expect: [
          EmailAuthenticationInitial(),
          EmailAuthenticationRequestInProgress(),
          EmailAuthenticationRequestSuccess(
            UserModel(
              email: 'email@gmail.com',
              phoneNumber: '123456689',
              displayName: 'display name',
              userID: '12345',
            ),
          ),
        ],
      );

      blocTest(
        'should emit initial then authenticating then AuthenticationFailure when SignedIn event is added and the usecase returns a left containing failure',
        build: () {
          when(mockSignInWithEmailAndPassword(any)).thenAnswer(
              (_) async => Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
          when(authenticationRepository.getCurrentUser()).thenAnswer(
              (_) async => Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
          return authenticationBloc;
        },
        act: (bloc) async {
          bloc.add(SignedIn(EmailAndPassword(
              email: 'hossam.elharmil@gmail.com', password: 'Test12345')));
        },
        expect: [
          EmailAuthenticationInitial(),
          EmailAuthenticationRequestInProgress(),
          EmailAuthenticationRequestFailure(
              AuthenticationFailure(AUTHENTICATION_FAILURE)),
        ],
      );
    });

    group('Sign out test', () {
      blocTest(
        'should emit initial then EmailAuthenticationRequestInProgress then EmailAuthenticationRequestSuccess when signedOut event is added and the usecase returns a right containing true',
        build: () {
          when(mockSignOut(any)).thenAnswer((_) async => Right(true));
          return authenticationBloc;
        },
        act: (bloc) async {
          bloc.add(SignedOut());
        },
        expect: [
          EmailAuthenticationInitial(),
          EmailAuthenticationRequestInProgress(),
          EmailAuthenticationInitial(),
        ],
      );

      blocTest(
        'should emit initial and EmailAuthenticationRequestInProgress then AuthenticationFailure when SignedIn event is added and the usecase returns a left containing failure',
        build: () {
          when(mockSignOut(any)).thenAnswer(
              (_) async => Left(AuthenticationFailure(AUTHENTICATION_FAILURE)));
          return authenticationBloc;
        },
        act: (bloc) async {
          bloc.add(SignedOut());
        },
        expect: [
          EmailAuthenticationInitial(),
          EmailAuthenticationRequestInProgress(),
          EmailAuthenticationRequestFailure(
              AuthenticationFailure(AUTHENTICATION_FAILURE)),
        ],
      );
    });
  });
}

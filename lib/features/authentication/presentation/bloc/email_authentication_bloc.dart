import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../domain/usecases/sign_in_with_email_and_password.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up_with_email_and_password.dart';

const AUTHENTICATION_FAILURE = "Authentication failed";

class EmailAuthenticationBloc
    extends Bloc<EmailAuthenticationEvent, EmailAuthenticationState> {
  final SignInWithEmailAndPassword _signInWithEmailAndPassword;
  final SignUpWithEmailAndPassword _signUpWithEmailAndPassword;
  final SignOut _signOut;
  final AuthenticationRepository _authenticationRepository;

  EmailAuthenticationBloc(
      {signInWithEmailAndPassword,
      signUpWithEmailAndPassword,
      signOut,
      repository})
      : assert(signInWithEmailAndPassword != null),
        assert(signUpWithEmailAndPassword != null),
        assert(signOut != null),
        assert(repository != null),
        _signInWithEmailAndPassword = signInWithEmailAndPassword,
        _signUpWithEmailAndPassword = signUpWithEmailAndPassword,
        _signOut = signOut,
        _authenticationRepository = repository;

  @override
  EmailAuthenticationState get initialState => EmailAuthenticationInitial();

  @override
  Stream<EmailAuthenticationState> mapEventToState(
    EmailAuthenticationEvent event,
  ) async* {
    if (event is SignedUp) {
      yield* _mapSignedUpToState(event);
    }
    if (event is SignedIn) {
      yield* _mapSignedInToState(event);
    }
    if (event is SignedOut) {
      yield* _mapSignedOutToState();
    }
  }

  Stream<EmailAuthenticationState> _mapSignedUpToState(SignedUp event) async* {
    yield EmailAuthenticationRequestInProgress();

    final signUpEither =
        await _signUpWithEmailAndPassword(event.emailAndPassword);

    yield* signUpEither.fold(
      (failure) async* {
        yield EmailAuthenticationRequestFailure(failure);
      },

      (boolResult) async* {
        final user = await _authenticationRepository.getCurrentUser();
        yield* user.fold(
          (failure) async* {
            yield EmailAuthenticationRequestFailure(failure);
          },
          (userResult) async* {
            yield EmailAuthenticationRequestSuccess(userResult);
          },
        );
      },
    );
  }

  Stream<EmailAuthenticationState> _mapSignedInToState(SignedIn event) async* {
    yield EmailAuthenticationRequestInProgress();

    final signInEither =
        await _signInWithEmailAndPassword(event.emailAndPassword);

    yield* signInEither.fold(
      (failure) async* {
        yield EmailAuthenticationRequestFailure(failure);
      },

      (boolResult) async* {
        final user = await _authenticationRepository.getCurrentUser();
        yield* user.fold(
          (failure) async* {
            yield EmailAuthenticationRequestFailure(failure);
          },
          (userResult) async* {
            yield EmailAuthenticationRequestSuccess(userResult);
          },
        );
      },
    );
  }

  Stream<EmailAuthenticationState> _mapSignedOutToState() async* {
    yield EmailAuthenticationRequestInProgress();
    final signOutEither = await _signOut(NoParams());
    yield* signOutEither.fold(
      (failure) async* {
        yield EmailAuthenticationRequestFailure(failure);
      },
      (boolResult) async* {
        yield EmailAuthenticationInitial();
      },
    );
  }
}

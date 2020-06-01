import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import './bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/verify_phone.dart';
import '../../domain/usecases/verify_sms_code.dart';

const TIMEOUT_DURATION = 30;

class VerifyPhoneBloc extends Bloc<VerifyPhoneEvent, VerifyPhoneState> {
  final VerifyPhone _verifyPhone;
  final VerifySmsCode _verifySmsCode;
  final GetCurrentUser _getCurrentUser;

  final Duration _verificationTimeout = Duration(seconds: TIMEOUT_DURATION);

  VerifyPhoneBloc(
      {@required VerifyPhone verifyPhone,
      @required VerifySmsCode verifySmsCode,
      @required GetCurrentUser getCurrentUser})
      : assert(verifyPhone != null),
        assert(verifySmsCode != null),
        assert(getCurrentUser != null),
        _verifyPhone = verifyPhone,
        _verifySmsCode = verifySmsCode,
        _getCurrentUser = getCurrentUser;

  @override
  VerifyPhoneState get initialState => VerifyPhoneInitial();

  @override
  Stream<VerifyPhoneState> mapEventToState(
    VerifyPhoneEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
    if (event is PhoneEntered) {
      yield* _mapPhoneEnteredToState(event);
    }
    if (event is CodeSent) {
      yield* _mapCodeSentToState(event);
    }
    if (event is CodeEntered) {
      yield* _mapCodeEnteredToState(event);
    }
    if (event is VerificationCompleted) {
      yield* _mapVerificationCompletedToState(event);
    }
    if (event is VerificationFailed) {
      yield* _mapVerificationFailedToState(event);
    }
  }

  _mapPhoneEnteredToState(PhoneEntered event) async {
    await _verifyPhone(VerifyPhoneParams(
      phoneNumber: event.phoneNumber,
      timeout: _verificationTimeout,
      autoRetrievalTimeout: (verificationID) {},
      codeSent: (verificationID, [int forceResendingToken]) {
        add(CodeSent(verificationID));
      },
      verificationCompleted: (auth) {
        add(VerificationCompleted());
      },
      verificationFailed: (exception) {
        add(VerificationFailed(exception.toString()));
      },
    ));
  }

  Stream<VerifyPhoneState> _mapAppStartedToState() async* {
    yield VerifyPhoneInProgress();

    final either = await _getCurrentUser(NoParams());

    yield* either.fold(
      (failure) async* {
        yield EnteringPhoneNumber();
      },
      (user) async* {
        yield VerifyPhoneSuccess(user);
      },
    );
  }

  Stream<VerifyPhoneState> _mapCodeSentToState(CodeSent event) async* {
    yield EnteringVerificationCode(event.verificationID);
  }

  Stream<VerifyPhoneState> _mapCodeEnteredToState(CodeEntered event) async* {
    yield VerifyPhoneInProgress();
    final either = await _verifySmsCode(VerifySmsCodeParams(
        verificationID: event.verificationID, smsCode: event.code));
    yield* either.fold(
      (failure) async* {
        if (failure is AuthenticationFailure)
          yield VerifyPhoneFailure(failure.message);
      },
      (user) async* {
        yield VerifyPhoneSuccess(user);
      },
    );
  }

  Stream<VerifyPhoneState> _mapVerificationCompletedToState(
      VerificationCompleted event) async* {
    yield VerifyPhoneInProgress();
    final either = await _getCurrentUser(NoParams());

    yield* either.fold(
      (failure) async* {
        if (failure is AuthenticationFailure) {
          yield VerifyPhoneFailure(failure.message);
        }
      },
      (user) async* {
        yield VerifyPhoneSuccess(user);
      },
    );
  }

  Stream<VerifyPhoneState> _mapVerificationFailedToState(
      VerificationFailed event) async* {
    yield VerifyPhoneFailure(event.message);
  }
}

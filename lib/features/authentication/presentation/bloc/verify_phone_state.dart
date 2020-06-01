import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

abstract class VerifyPhoneState extends Equatable {
  const VerifyPhoneState();
}

class VerifyPhoneInitial extends VerifyPhoneState {
  @override
  List<Object> get props => [];
}

class EnteringPhoneNumber extends VerifyPhoneState{
  @override
  List<Object> get props => [];
}

class VerifyPhoneInProgress extends VerifyPhoneState {
  @override
  List<Object> get props => null;
}

class VerifyPhoneFailure extends VerifyPhoneState {
  final String message;

  VerifyPhoneFailure(this.message);
  @override
  List<Object> get props => [message];
}

class EnteringVerificationCode extends VerifyPhoneState {
  final String verificationID;

  EnteringVerificationCode(this.verificationID);
  @override
  List<Object> get props => [verificationID];
}

class VerifyingCodeInProgress extends VerifyPhoneState {
  @override
  List<Object> get props => [];
}

class VerifyPhoneSuccess extends VerifyPhoneState {
  final User user;

  VerifyPhoneSuccess(this.user);
  @override
  List<Object> get props => [user];
}


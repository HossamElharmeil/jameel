import 'package:equatable/equatable.dart';

abstract class VerifyPhoneEvent extends Equatable {
  const VerifyPhoneEvent();
}

class AppStarted extends VerifyPhoneEvent {
  @override
  List<Object> get props => [];
}

class PhoneEntered extends VerifyPhoneEvent {
  final String phoneNumber;

  PhoneEntered(this.phoneNumber);
  @override
  List<Object> get props => [phoneNumber];
}

class VerificationCompleted extends VerifyPhoneEvent {
  @override
  List<Object> get props => [];
}

class VerificationFailed extends VerifyPhoneEvent {
  final String message;

  VerificationFailed(this.message);
  @override
  List<Object> get props => [message];
}

class CodeSent extends VerifyPhoneEvent {
  final String verificationID;

  CodeSent(this.verificationID);
  @override
  List<Object> get props => [verificationID];
}

class CodeEntered extends VerifyPhoneEvent {
  final String verificationID;
  final String code;

  CodeEntered(this.verificationID, this.code);
  @override
  List<Object> get props => [verificationID, code];
}

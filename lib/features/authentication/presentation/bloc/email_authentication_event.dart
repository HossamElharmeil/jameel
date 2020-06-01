import 'package:equatable/equatable.dart';
import 'package:jameel/core/util/email_and_password.dart';

abstract class EmailAuthenticationEvent extends Equatable {
  const EmailAuthenticationEvent();
}

class SignedUp extends EmailAuthenticationEvent {
  final EmailAndPassword emailAndPassword;

  SignedUp(this.emailAndPassword);

  @override
  List<Object> get props => [emailAndPassword];
}

class SignedIn extends EmailAuthenticationEvent {
  final EmailAndPassword emailAndPassword;

  SignedIn(this.emailAndPassword);

  @override
  List<Object> get props => [emailAndPassword];
}

class SignedOut extends EmailAuthenticationEvent {
  @override
  List<Object> get props => [];
}

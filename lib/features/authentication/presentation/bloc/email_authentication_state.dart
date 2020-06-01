import 'package:equatable/equatable.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/authentication/domain/entities/user.dart';

abstract class EmailAuthenticationState extends Equatable {
  const EmailAuthenticationState();
}

class EmailAuthenticationInitial extends EmailAuthenticationState {
  @override
  List<Object> get props => [];
}

class EmailAuthenticationRequestSuccess extends EmailAuthenticationState {
  final User user;

  EmailAuthenticationRequestSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class EmailAuthenticationRequestInProgress extends EmailAuthenticationState {
  @override
  List<Object> get props => [];
}

class EmailAuthenticationRequestFailure extends EmailAuthenticationState {
  final Failure failure;

  EmailAuthenticationRequestFailure(this.failure);
  @override
  List<Object> get props => [failure];
}
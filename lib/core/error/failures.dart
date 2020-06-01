import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class RepositoryFailure extends Failure {
  final String message;

  RepositoryFailure(this.message);

  @override
  List<Object> get props => [message];
}

class FirestoreFailure extends Failure {
  final String message;

  FirestoreFailure(this.message);

  @override
  List<Object> get props => [message];
}

class AuthenticationFailure extends Failure {
  final String message;

  AuthenticationFailure(this.message);
  @override
  List<Object> get props => [message];
}

class SearchFailure extends Failure {
  final String message;

  SearchFailure(this.message);
  @override
  List<Object> get props => [message];
}

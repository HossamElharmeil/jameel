import 'package:equatable/equatable.dart';

abstract class SubmitReviewState extends Equatable {
  const SubmitReviewState();
}

class SubmitReviewInitial extends SubmitReviewState {
  @override
  List<Object> get props => [];
}

class SubmitReviewInProgress extends SubmitReviewState {
  @override
  List<Object> get props => [];
}

class SubmitReviewSuccess extends SubmitReviewState {
  @override
  List<Object> get props => [];
}

class SubmitReviewFail extends SubmitReviewState {
  final String message;

  SubmitReviewFail(this.message);
  @override
  List<Object> get props => [message];
}

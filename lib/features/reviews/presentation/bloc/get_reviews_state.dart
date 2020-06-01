import 'package:equatable/equatable.dart';
import 'package:jameel/features/reviews/domain/entities/review.dart';

abstract class GetReviewsState extends Equatable {
  const GetReviewsState();
}

class GetReviewsInitial extends GetReviewsState {
  @override
  List<Object> get props => [];
}

class GetReviewsInProgress extends GetReviewsState {
  @override
  List<Object> get props => [];
}

class GetReviewsSuccess extends GetReviewsState {
  final List<Review> reviewsList;

  GetReviewsSuccess(this.reviewsList);
  @override
  List<Object> get props => [reviewsList];
}

class GetReviewsFail extends GetReviewsState {
  final String message;

  GetReviewsFail(this.message);

  @override
  List<Object> get props => [message];
}

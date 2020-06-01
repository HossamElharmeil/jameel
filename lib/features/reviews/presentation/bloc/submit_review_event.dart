import 'package:equatable/equatable.dart';
import 'package:jameel/features/reviews/domain/entities/review.dart';

abstract class SubmitReviewEvent extends Equatable {
  const SubmitReviewEvent();
}

class ReviewSubmitted extends SubmitReviewEvent {
  final Review review;
  final String shopID;

  ReviewSubmitted(this.review, this.shopID);
  @override
  List<Object> get props => [review];
}

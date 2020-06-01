import 'package:equatable/equatable.dart';

abstract class GetReviewsEvent extends Equatable {
  const GetReviewsEvent();
}

class ReviewsRequested extends GetReviewsEvent {
  final String shopID;

  ReviewsRequested(this.shopID);
  @override
  List<Object> get props => [shopID];
}

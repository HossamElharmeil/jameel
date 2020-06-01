import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/review.dart';
import '../repositories/reviews_repository.dart';

class SubmitReview extends UseCase<bool, SubmitReviewParams> {
  final ReviewsRepository _reviewsRepository;

  SubmitReview({@required ReviewsRepository repository})
      : assert(repository != null),
        _reviewsRepository = repository;

  @override
  Future<Either<Failure, bool>> call(SubmitReviewParams params) {
    return _reviewsRepository.submitReview(params.review, params.shopID);
  }
}

class SubmitReviewParams {
  final Review review;
  final String shopID;

  SubmitReviewParams({this.review, this.shopID});
}

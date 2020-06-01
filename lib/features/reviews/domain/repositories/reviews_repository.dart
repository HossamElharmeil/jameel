import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/review.dart';

abstract class ReviewsRepository {
  Future<Either<Failure, List<Review>>> getReviews(String shopID);
  Future<Either<Failure, bool>> submitReview(Review review, String shopID);
}

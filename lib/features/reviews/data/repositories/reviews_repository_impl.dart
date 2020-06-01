import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/reviews_repository.dart';
import '../data_sources/reviews_data_source.dart';

class ReviewsRepositoryImpl extends ReviewsRepository {
  final ReviewsDataSource _reviewsDataSource;

  ReviewsRepositoryImpl({@required ReviewsDataSource dataSource})
      : assert(dataSource != null),
        _reviewsDataSource = dataSource;

  @override
  Future<Either<Failure, List<Review>>> getReviews(String shopID) async {
    try {
      return Right(await _reviewsDataSource.getReviews(shopID));
    } catch (e) {
      return Left(FirestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> submitReview(Review review, String shopID) async {
    try {
      await _reviewsDataSource.submitReview(review, shopID);
      return Future.value(Right(true));
    } catch (e) {
      return Left(FirestoreFailure(e.toString()));
    }
  }
}

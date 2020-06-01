import 'package:dartz/dartz.dart';
import '../repositories/reviews_repository.dart';

import '../../../../core/error/failures.dart';
import 'package:meta/meta.dart';
import '../../../../core/usecase.dart';
import '../entities/review.dart';

class GetReviews extends UseCase<List<Review>, String> {
  final ReviewsRepository reviewsRepository;

  GetReviews({@required this.reviewsRepository});
  @override
  Future<Either<Failure, List<Review>>> call(String shopID) async {
    return await reviewsRepository.getReviews(shopID);
  }
}

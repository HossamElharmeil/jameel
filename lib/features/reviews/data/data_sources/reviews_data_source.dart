import '../../domain/entities/review.dart';
import '../models/review_model.dart';

abstract class ReviewsDataSource {
  Future<List<Review>> getReviews(String shopID);
  Future<bool> submitReview(ReviewModel review, String shopID);
}

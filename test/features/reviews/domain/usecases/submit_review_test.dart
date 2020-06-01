import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/reviews/data/models/review_model.dart';
import 'package:jameel/features/reviews/domain/repositories/reviews_repository.dart';
import 'package:jameel/features/reviews/domain/usecases/submit_review.dart';
import 'package:mockito/mockito.dart';

const FIRESTORE_FAILURE = 'Unable to submit review';

class MockReviewsRepository extends Mock implements ReviewsRepository {}

void main() {
  ReviewsRepository mockReviewsRepository;
  SubmitReview submitReview;
  ReviewModel reviewModel;
  String tShopID = 'test shopID';
  SubmitReviewParams params;

  setUp(() {
    mockReviewsRepository = MockReviewsRepository();
    submitReview = SubmitReview(repository: mockReviewsRepository);
    reviewModel = ReviewModel(
        dateTime: DateTime(2020, 4, 3),
        rating: 4.2,
        review: 'test review string',
        userID: 'test userID');
    params = SubmitReviewParams(review: reviewModel, shopID: tShopID);
  });

  test('should forward the call to the repository and return the output',
      () async {
    when(mockReviewsRepository.submitReview(reviewModel, tShopID))
        .thenAnswer((_) async => Right(true));

    final result = await submitReview(params);

    verify(mockReviewsRepository.submitReview(reviewModel, tShopID));
    expect(result, Right(true));
  });

  test(
      'should return a left of either containing failure when the call to the repository is unsuccessful',
      () async {
    when(mockReviewsRepository.submitReview(reviewModel, tShopID))
        .thenAnswer((_) async => Left(FirestoreFailure(FIRESTORE_FAILURE)));

    final result = await submitReview(params);

    verify(mockReviewsRepository.submitReview(reviewModel, tShopID));
    expect(result, Left(FirestoreFailure(FIRESTORE_FAILURE)));
  });
}

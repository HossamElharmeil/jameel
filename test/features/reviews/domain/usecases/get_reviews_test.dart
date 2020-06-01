import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/reviews/domain/entities/review.dart';
import 'package:jameel/features/reviews/domain/repositories/reviews_repository.dart';
import 'package:jameel/features/reviews/domain/usecases/get_reviews.dart';
import 'package:mockito/mockito.dart';

class MockReviewsRepository extends Mock implements ReviewsRepository {}

void main() {
  ReviewsRepository mockReviewsRepository;
  GetReviews getReviews;
  String tShopID = 'test shopID';
  List<Review> reviewList = [
    Review(
        userID: 'test userID',
        rating: 3.3,
        review: 'test review',
        dateTime: DateTime(2020, 3, 10))
  ];

  setUp(() {
    mockReviewsRepository = MockReviewsRepository();
    getReviews = GetReviews(reviewsRepository: mockReviewsRepository);
  });

  test(
    'should forward the call to the reviews repository and return the result',
    () async {
      when(mockReviewsRepository.getReviews(any))
          .thenAnswer((_) async => Right(reviewList));

      final result = await getReviews(tShopID);

      verify(mockReviewsRepository.getReviews(tShopID));
      expect(result, Right(reviewList));
    },
  );

  test(
      'should return a left with a failure when the repository call is unsuccessful',
      () async {
    when(mockReviewsRepository.getReviews(any)).thenAnswer(
        (_) async => Left(FirestoreFailure("Could not get reviews")));

    final result = await getReviews(tShopID);

    verify(mockReviewsRepository.getReviews(tShopID));
    expect(result, Left(FirestoreFailure("Could not get reviews")));
  });
}

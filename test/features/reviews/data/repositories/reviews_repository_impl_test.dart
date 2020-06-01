import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/exceptions.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/reviews/data/data_sources/reviews_data_source.dart';
import 'package:jameel/features/reviews/data/models/review_model.dart';
import 'package:jameel/features/reviews/data/repositories/reviews_repository_impl.dart';
import 'package:jameel/features/reviews/domain/entities/review.dart';
import 'package:jameel/features/reviews/domain/repositories/reviews_repository.dart';
import 'package:mockito/mockito.dart';

class MockReviewsDataSource extends Mock implements ReviewsDataSource {}

void main() {
  ReviewsDataSource mockReviewsDataSource;
  ReviewsRepository reviewsRepository;
  String tShopID = 'test shopID';
  ReviewModel reviewModel;
  List<Review> reviewList = [
    Review(
        userID: 'test userID',
        rating: 3.3,
        review: 'test review',
        dateTime: DateTime(2020, 3, 10))
  ];

  setUp(() {
    mockReviewsDataSource = MockReviewsDataSource();
    reviewsRepository =
        ReviewsRepositoryImpl(dataSource: mockReviewsDataSource);
    reviewModel = ReviewModel(
        dateTime: DateTime(2020, 4, 3),
        rating: 4.2,
        review: 'test review string',
        userID: 'test userID');
  });
  group('Get reviews test', () {
    test(
        'should forward the call to the data source with the shopID and return the list if successful',
        () async {
      when(mockReviewsDataSource.getReviews(tShopID))
          .thenAnswer((_) async => reviewList);

      final result = await reviewsRepository.getReviews(tShopID);

      verify(mockReviewsDataSource.getReviews(tShopID));
      expect(result, Right(reviewList));
    });

    test(
      'should return a left containing a failure when the call to the data source throws an exception',
      () async {
        final exception = FirestoreException();

        when(mockReviewsDataSource.getReviews(tShopID)).thenThrow(exception);

        final result = await reviewsRepository.getReviews(tShopID);

        verify(mockReviewsDataSource.getReviews(tShopID));
        expect(result, Left(FirestoreFailure(exception.toString())));
      },
    );
  });

  group('Submit review test', () {
    test(
        'should forward the call to the data source with the shopID and return the list if successful',
        () async {
      when(mockReviewsDataSource.submitReview(reviewModel, tShopID))
          .thenAnswer((_) async => true);

      final result = await reviewsRepository.submitReview(reviewModel, tShopID);

      verify(mockReviewsDataSource.submitReview(reviewModel, tShopID));
      expect(result, Right(true));
    });

    test(
      'should return a left containing a failure when the call to the data source throws an exception',
      () async {
        final exception = FirestoreException();

        when(mockReviewsDataSource.submitReview(reviewModel, tShopID))
            .thenThrow(exception);

        final result = await reviewsRepository.submitReview(reviewModel, tShopID);

        verify(mockReviewsDataSource.submitReview(reviewModel, tShopID));
        expect(result, Left(FirestoreFailure(exception.toString())));
      },
    );
  });
}

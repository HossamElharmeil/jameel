import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/reviews/data/models/review_model.dart';
import 'package:jameel/features/reviews/domain/usecases/get_reviews.dart';
import 'package:jameel/features/reviews/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';

const GET_REVIEWS_FAILURE = 'Unable to get reviews';

class MockGetReviews extends Mock implements GetReviews {}

void main() {
  GetReviews mockGetReviews;
  GetReviewsBloc getReviewsBloc;
  String tShopID = 'test shop ID';
  List<ReviewModel> tReviewList = [
    ReviewModel(
        dateTime: DateTime(500, 400),
        rating: 2.5,
        review: 'test review',
        userID: 'test user ID'),
  ];

  setUp(() {
    mockGetReviews = MockGetReviews();
    getReviewsBloc = GetReviewsBloc(getReviews: mockGetReviews);
  });

  blocTest(
    'should emit GetReviewsSuccess with a list of reviews when the usecase returns a right of either containing the list',
    build: () {
      when(mockGetReviews(any)).thenAnswer((_) async => Right(tReviewList));
      return getReviewsBloc;
    },
    act: (bloc) async {
      await bloc.add(ReviewsRequested(tShopID));
    },
    expect: [
      GetReviewsInitial(),
      GetReviewsInProgress(),
      GetReviewsSuccess(tReviewList),
    ],
  );

  blocTest(
    'should emit GetReviewsFail with an error message when the use case returns a left of either',
    build: () {
      when(mockGetReviews(any))
          .thenAnswer((_) async => Left(FirestoreFailure(GET_REVIEWS_FAILURE)));
      return getReviewsBloc;
    },
    act: (bloc) async {
      await bloc.add(ReviewsRequested(tShopID));
    },
    expect: [
      GetReviewsInitial(),
      GetReviewsInProgress(),
      GetReviewsFail(GET_REVIEWS_FAILURE),
    ],
  );
}

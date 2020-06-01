import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/reviews/data/models/review_model.dart';
import 'package:jameel/features/reviews/domain/usecases/submit_review.dart';
import 'package:jameel/features/reviews/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';

const SUBMIT_REVIEW_FAILURE = 'Unable to submit review';

class MockSubmitReview extends Mock implements SubmitReview {}

void main() {
  SubmitReview mockSubmitReview;
  SubmitReviewBloc submitReviewBloc;
  ReviewModel tReviewModel;
  String tShopID;
  setUp(() {
    mockSubmitReview = MockSubmitReview();
    submitReviewBloc = SubmitReviewBloc(submitReview: mockSubmitReview);
    tReviewModel = ReviewModel(
        dateTime: DateTime(399, 4888),
        rating: 3.0,
        review: 'test review',
        userID: 'test userID');
    tShopID = 'test shop ID';
  });

  blocTest(
    'should emit a SubmitReviewSuccess when the call to the usecase returns a right',
    build: () {
      when(mockSubmitReview(any)).thenAnswer((_) async => Right(true));
      return submitReviewBloc;
    },
    act: (bloc) async {
      await bloc.add(ReviewSubmitted(tReviewModel, tShopID));
    },
    expect: [
      SubmitReviewInitial(),
      SubmitReviewInProgress(),
      SubmitReviewSuccess(),
    ],
  );

  blocTest(
    'should emit SubmitReviewFail when the usecase returns a left',
    build: () {
      when(mockSubmitReview(any)).thenAnswer(
          (_) async => Left(FirestoreFailure(SUBMIT_REVIEW_FAILURE)));
      return submitReviewBloc;
    },
    act: (bloc) async {
      await bloc.add(ReviewSubmitted(tReviewModel, tShopID));
    },
    expect: [
      SubmitReviewInitial(),
      SubmitReviewInProgress(),
      SubmitReviewFail(SUBMIT_REVIEW_FAILURE),
    ],
  );
}

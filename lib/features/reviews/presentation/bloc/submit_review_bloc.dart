import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/reviews/domain/usecases/submit_review.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class SubmitReviewBloc extends Bloc<SubmitReviewEvent, SubmitReviewState> {
  final SubmitReview _submitReview;

  SubmitReviewBloc({@required SubmitReview submitReview})
      : assert(submitReview != null),
        _submitReview = submitReview;

  @override
  SubmitReviewState get initialState => SubmitReviewInitial();

  @override
  Stream<SubmitReviewState> mapEventToState(
    SubmitReviewEvent event,
  ) async* {
    if (event is ReviewSubmitted) {
      yield* _mapReviewSubmittedToState(event);
    }
  }

  Stream<SubmitReviewState> _mapReviewSubmittedToState(
      ReviewSubmitted event) async* {
    yield SubmitReviewInProgress();

    final either = await _submitReview(
        SubmitReviewParams(review: event.review, shopID: event.shopID));

    yield* either.fold(
      (failure) async* {
        if (failure is FirestoreFailure)
          yield SubmitReviewFail(failure.message);
      },
      (result) async* {
        yield SubmitReviewSuccess();
      },
    );
  }
}

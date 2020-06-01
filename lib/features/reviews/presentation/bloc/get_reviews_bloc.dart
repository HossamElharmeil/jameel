import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:jameel/core/error/failures.dart';
import 'package:jameel/features/reviews/domain/usecases/get_reviews.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class GetReviewsBloc extends Bloc<GetReviewsEvent, GetReviewsState> {
  final GetReviews _getReviews;

  GetReviewsBloc({@required GetReviews getReviews})
      : assert(getReviews != null),
        _getReviews = getReviews;

  @override
  GetReviewsState get initialState => GetReviewsInitial();

  @override
  Stream<GetReviewsState> mapEventToState(
    GetReviewsEvent event,
  ) async* {
    if (event is ReviewsRequested) {
      yield* _mapReviewsRequestedToState(event);
    }
  }

  Stream<GetReviewsState> _mapReviewsRequestedToState(
      ReviewsRequested event) async* {
    yield GetReviewsInProgress();

    final either = await _getReviews(event.shopID);

    yield* either.fold(
      (failure) async* {
        if (failure is FirestoreFailure) yield GetReviewsFail(failure.message);
      },
      (reviewsList) async* {
        yield GetReviewsSuccess(reviewsList);
      },
    );
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_reservations.dart';
import '../../domain/usecases/make_reservation.dart';

const String UNIMPLEMENTED_ERROR = "Unimplemented error";

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final GetReservations getReservations;
  final MakeReservation makeReservation;

  ReservationBloc({
    @required this.getReservations,
    @required this.makeReservation,
  });
  @override
  ReservationState get initialState => ReservationsInitial();

  @override
  Stream<ReservationState> mapEventToState(
    ReservationEvent event,
  ) async* {
    if (event is ReservationsRequested) {
      yield* _mapReservationsRequestedToState(event);
    }
    if (event is ReservationSubmitted) {
      await makeReservation(event.reservation);
    }
  }

  Stream<ReservationState> _mapReservationsRequestedToState(
      ReservationsRequested event) async* {
    yield ReservationsLoadInProgress();
    final reservations =
        await getReservations(GetReservationParams(userID: event.userID));

    yield* reservations.fold((failure) async* {
      if (failure is FirestoreFailure) {
        yield ReservationsLoadFailure(failure.message);
      } else {
        yield ReservationsLoadFailure(UNIMPLEMENTED_ERROR);
      }
    }, (list) async* {
      yield ReservationsLoadSuccess(list);
    });
  }
}

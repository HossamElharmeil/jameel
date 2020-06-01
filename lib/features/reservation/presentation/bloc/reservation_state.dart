import 'package:equatable/equatable.dart';
import 'package:jameel/features/reservation/domain/entities/reservation.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();
}

class ReservationsInitial extends ReservationState {
  @override
  List<Object> get props => [];
}

class ReservationsLoadInProgress extends ReservationState {
  @override
  List<Object> get props => [];
}

class ReservationsLoadSuccess extends ReservationState {
  final List<Reservation> list;
  
  ReservationsLoadSuccess(this.list);

  @override
  List<Object> get props => [list];
}

class ReservationsLoadFailure extends ReservationState {
  final String message;

  ReservationsLoadFailure(this.message);
  @override
  List<Object> get props => [message];
}

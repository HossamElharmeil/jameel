import 'package:equatable/equatable.dart';
import 'package:jameel/features/reservation/domain/entities/reservation.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();
}

class ReservationsRequested extends ReservationEvent{

  final String userID;

  ReservationsRequested(this.userID);
  @override
  List<Object> get props => [userID];
}

class ReservationSubmitted extends ReservationEvent{
  final Reservation reservation;

  ReservationSubmitted(this.reservation);
  
  @override
  List<Object> get props => [reservation];
}
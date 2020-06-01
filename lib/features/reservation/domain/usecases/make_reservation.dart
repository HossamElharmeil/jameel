import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class MakeReservation extends UseCase<void, Reservation> {
  final ReservationRepository reservationRepository;
  MakeReservation({this.reservationRepository});

  @override
  Future<Either<Failure, bool>> call(Reservation reservation) async {
    final result = await reservationRepository.makeReservation(reservation);
    return result;
  }
}
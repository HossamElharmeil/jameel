import 'package:dartz/dartz.dart';
import 'package:jameel/features/reservation/domain/entities/service.dart';

import '../../../../core/error/failures.dart';
import '../entities/reservation.dart';

abstract class ReservationRepository{

  Future<Either<Failure, bool>> makeReservation(Reservation reservation);
  Future<Either<Failure, List<Reservation>>> getReservations(String userID);
  Future<Either<Failure, List<Service>>> getServices(String shopID);
}
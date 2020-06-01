import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase.dart';
import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class GetReservations extends UseCase<List, GetReservationParams> {
  final ReservationRepository reservationRepository;

  GetReservations({@required this.reservationRepository});
  @override
  Future<Either<Failure, List<Reservation>>> call(GetReservationParams params) async {

    return await reservationRepository.getReservations(params.userID);
    
  }
}

class GetReservationParams{
  final String userID;

  GetReservationParams({this.userID});
}